# frozen_string_literal: true

require 'test_helper'

class DecompressTest < MiniTest::Test
  FILE = 'test/data/file1.txt'
  BZIP2_FILE = 'test/data/file1.txt.bz2'

  def setup
    @decompress = Zip::Bzip2::Decompress.new
  end

  def test_decompress
    assert_equal(file_text, @decompress.decompress(compressed_data))
    assert_equal(true, @decompress.finished?)
  end

  def test_decompress_partial
    assert_equal('', @decompress.decompress(compressed_data[0..300]))
    assert_equal(false, @decompress.finished?)
    assert_equal(file_text, @decompress.decompress(compressed_data[301..600]))
    assert_equal(true, @decompress.finished?)
  end

  def test_decompress_with_invalid_magic
    input = compressed_data
    input[0] = 'X'

    assert_raises(Zip::Bzip2::MagicDataError) do
      @decompress.decompress(input)
    end
  end

  def test_decompress_with_corrupted_input
    input = compressed_data
    input[40] = 'X'

    assert_raises(Zip::Bzip2::DataError) do
      @decompress.decompress(input)
    end
  end

  private

  def file_text
    @file_text ||= File.open(FILE, &:read)
  end

  def compressed_data
    @compressed_data ||= File.open(BZIP2_FILE, &:read)
  end
end
