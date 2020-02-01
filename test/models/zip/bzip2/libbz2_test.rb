# frozen_string_literal: true

require 'test_helper'

class Libbz2Test < MiniTest::Test
  FILE = 'test/data/file1.txt'
  BZIP2_FILE = 'test/data/file1.txt.bz2'

  def test_libbz2_decompression
    output = decompress(compressed_data)
    assert_equal(file_text, output)
  end

  def test_libbz2_decompression_with_invalid_magic
    input = compressed_data
    input[0] = 'X'

    assert_raises(Zip::Bzip2::MagicDataError) do
      decompress(input)
    end
  end

  def test_libbz2_decompression_with_corrupted_input
    input = compressed_data
    input[40] = 'X'

    assert_raises(Zip::Bzip2::DataError) do
      decompress(input)
    end
  end

  def test_invalid_libbz2_configuration
    Zip::Bzip2::FFI::Libbz2.stub(:BZ2_bzDecompressInit, Zip::Bzip2::FFI::Libbz2::BZ_CONFIG_ERROR) do
      assert_raises(Zip::Bzip2::ConfigError) do
        decompress(compressed_data)
      end
    end
  end

  def test_libbz2_decompression_with_libbz2_memory_error
    Zip::Bzip2::FFI::Libbz2.stub(:BZ2_bzDecompress, Zip::Bzip2::FFI::Libbz2::BZ_MEM_ERROR) do
      assert_raises(Zip::Bzip2::MemError) do
        decompress(compressed_data)
      end
    end
  end

  def test_libbz2_decompression_with_unexpected_error
    Zip::Bzip2::FFI::Libbz2.stub(:BZ2_bzDecompress, Zip::Bzip2::FFI::Libbz2::BZ_PARAM_ERROR) do
      assert_raises(Zip::Bzip2::UnexpectedError) do
        decompress(compressed_data)
      end
    end
  end

  private

  def decompress(data)
    input_buffer = Zip::Bzip2::Libbz2.buffer_from_data(data)
    output_buffer = Zip::Bzip2::Libbz2.buffer(4096)

    libbz2 = Zip::Bzip2::Libbz2.new
    libbz2.input_buffer = input_buffer
    libbz2.output_buffer = output_buffer
    libbz2.decompress_init!
    libbz2.decompress!
    output = libbz2.output
    libbz2.decompress_end!

    output_buffer.free
    input_buffer.free

    output
  end

  def file_text
    @file_text ||= File.open(FILE, &:read)
  end

  def compressed_data
    @compressed_data ||= File.open(BZIP2_FILE, &:read)
  end
end
