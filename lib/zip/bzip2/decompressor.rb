# frozen_string_literal: true

require 'zip'
require 'zip/bzip2/decompress'

module Zip #:nodoc:
  module Bzip2
    class Decompressor < ::Zip::Decompressor #:nodoc:
      def initialize(*args)
        super

        @buffer = ''.dup
        @bzip2_ffi_decompressor = ::Zip::Bzip2::Decompress.new
      end

      def read(length = nil, outbuf = ''.dup)
        return return_value_on_eof(length) if eof

        fill_buffer(length)

        outbuf.replace(@buffer.slice!(0...(length || @buffer.bytesize)))
      end

      def eof
        @buffer.empty? && input_finished?
      end

      alias eof? eof

      private

      def return_value_on_eof(length)
        return '' if length.nil? || length.zero?
      end

      def fill_buffer(min_length)
        while min_length.nil? || (@buffer.bytesize < min_length)
          break if input_finished?

          @buffer << produce_input
        end
      end

      def produce_input
        @bzip2_ffi_decompressor.decompress(input_stream.read(Decompressor::CHUNK_SIZE))
      rescue Bzip2::Error
        raise(::Zip::DecompressionError, 'bzip2 error while decompressing')
      end

      def input_finished?
        @bzip2_ffi_decompressor.finished?
      end
    end
  end

  ::Zip::Decompressor.register(::Zip::COMPRESSION_METHOD_BZIP2, ::Zip::Bzip2::Decompressor)
end
