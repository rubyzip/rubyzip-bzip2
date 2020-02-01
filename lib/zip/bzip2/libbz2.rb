# frozen_string_literal: true

require 'ffi'
require 'zip/bzip2/errors'
require 'zip/bzip2/ffi/libbz2'

module Zip
  module Bzip2
    class Libbz2 #:nodoc:
      def self.finalizer
        lambda do |_id|
          decompress_end
        end
      end
      private_class_method :finalizer

      def self.buffer(length)
        ::FFI::MemoryPointer.new(1, length)
      end

      def self.buffer_from_data(data)
        buffer = ::FFI::MemoryPointer.new(1, data.bytesize)
        buffer.write_bytes(data)
        buffer
      end

      def initialize
        @stream = FFI::Libbz2::BzStream.new
      end

      def decompress_init!(small = false)
        result = FFI::Libbz2::BZ2_bzDecompressInit(@stream, 0, small ? 1 : 0)
        check_error(result)

        ObjectSpace.define_finalizer(self, self.class.send(:finalizer))

        true
      end

      def decompress!
        result = FFI::Libbz2::BZ2_bzDecompress(@stream)
        check_error(result)

        result == FFI::Libbz2::BZ_STREAM_END
      end

      def decompress_end!
        result = FFI::Libbz2::BZ2_bzDecompressEnd(@stream)
        check_error(result)

        ObjectSpace.undefine_finalizer(self)

        true
      end

      def input_buffer=(input_buffer)
        @stream[:next_in] = input_buffer
        @stream[:avail_in] = input_buffer.size
      end

      def output_buffer=(output_buffer)
        @output_buffer = output_buffer
        @stream[:next_out] = output_buffer
        @stream[:avail_out] = output_buffer.size
      end

      def input?
        @stream[:avail_in].positive?
      end

      def output
        @output_buffer.read_bytes(@output_buffer.size - @stream[:avail_out])
      end

      private

      def check_error(result)
        return if result >= 0

        raise error(result)
      end

      def error(result)
        case result
        when FFI::Libbz2::BZ_MEM_ERROR
          MemError
        when FFI::Libbz2::BZ_DATA_ERROR
          DataError
        when FFI::Libbz2::BZ_DATA_ERROR_MAGIC
          MagicDataError
        when FFI::Libbz2::BZ_CONFIG_ERROR
          ConfigError
        else
          raise UnexpectedError, result
        end
      end
    end
  end
end
