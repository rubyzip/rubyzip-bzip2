# frozen_string_literal: true

require 'test_helper'

class DecompressorTest < MiniTest::Test
  FILE1 = 'test/data/file1.txt'
  BZIP2_FILE = 'test/data/file1.txt.bz2'
  BZIP2_FILE_CORRUPT = 'test/data/file1.txt.corrupt.bz2'

  def test_read_everything
    File.open(BZIP2_FILE, 'rb') do |file|
      decompressor = ::Zip::Bzip2::Decompressor.new(file)

      assert_equal(test_text, decompressor.read)
    end
  end

  def test_read_in_chunks
    File.open(BZIP2_FILE, 'rb') do |file|
      decompressor = ::Zip::Bzip2::Decompressor.new(file)
      chunk_size = 5

      while (decompressed_chunk = decompressor.read(chunk_size))
        assert_equal(test_text.slice!(0, chunk_size), decompressed_chunk)
      end
      assert_equal(0, test_text.size)
    end
  end

  def test_data_error
    File.open(BZIP2_FILE_CORRUPT, 'rb') do |file|
      decompressor = ::Zip::Bzip2::Decompressor.new(file)
      assert_raises(::Zip::DecompressionError) do
        decompressor.read
      end
    end
  end

  private

  def test_text
    @test_text ||= File.open(FILE1, &:read)
  end
end
