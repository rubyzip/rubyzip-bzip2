# frozen_string_literal: true

require 'zip/bzip2/libbz2'

module Zip
  module Bzip2
    class Decompress #:nodoc:
      OUTPUT_BUFFER_SIZE = 4096

      def initialize(options = {})
        small = options[:small]

        @libbz2 = Libbz2.new.tap do |libbz2|
          libbz2.decompress_init!(small)
        end

        @finished = false
      end

      def decompress(data)
        result = ''.dup

        with_input_buffer(data) do |input_buffer|
          @libbz2.input_buffer = input_buffer

          with_output_buffer(OUTPUT_BUFFER_SIZE) do |output_buffer|
            while @libbz2.input?
              @libbz2.output_buffer = output_buffer

              @finished = @libbz2.decompress!
              result += @libbz2.output
              next unless @finished

              @libbz2.decompress_end!
              break
            end
          end
        end

        result
      end

      def finished?
        @finished
      end

      private

      def with_input_buffer(data)
        input_buffer = nil
        begin
          input_buffer = Libbz2.buffer_from_data(data)
          yield input_buffer
        ensure
          input_buffer&.free
        end
      end

      def with_output_buffer(length)
        output_buffer = nil
        begin
          output_buffer = Libbz2.buffer(length)
          yield output_buffer
        ensure
          output_buffer&.free
        end
      end
    end
  end
end
