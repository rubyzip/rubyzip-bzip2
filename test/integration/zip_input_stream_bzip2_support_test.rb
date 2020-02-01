# frozen_string_literal: true

require 'test_helper'

class ZipInputStreamBzip2SupportTest < MiniTest::Test
  FILE1 = 'test/data/file1.txt'
  FILE2 = 'test/data/file2.txt'
  BZIP2_ZIP_FILE = 'test/data/zipWithBzip2Compression.zip'
  BZIP2_ZIP_FILE_ENCRYPTED = 'test/data/zipWithBzip2CompressionAndEncryption.zip'
  PASSWORD = 'password'

  def test_input_stream_read
    Zip::InputStream.open(BZIP2_ZIP_FILE) do |zis|
      zis.get_next_entry
      assert_equal file1_text, zis.read

      zis.get_next_entry
      assert_equal file2_text, zis.read
    end
  end

  def test_input_stream_encrypted_read
    Zip::InputStream.open(BZIP2_ZIP_FILE_ENCRYPTED, 0, Zip::TraditionalDecrypter.new(PASSWORD)) do |zis|
      zis.get_next_entry
      assert_equal file1_text, zis.read

      zis.get_next_entry
      assert_equal file2_text, zis.read
    end
  end

  private

  def file1_text
    @file1_text ||= File.open(FILE1, 'r').read
  end

  def file2_text
    @file2_text ||= File.open(FILE2, 'r').read
  end
end
