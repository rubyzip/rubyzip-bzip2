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
    decrypter = Zip::TraditionalDecrypter.new(PASSWORD)

    Zip::InputStream.open(BZIP2_ZIP_FILE_ENCRYPTED, decrypter: decrypter) do |zis|
      zis.get_next_entry
      assert_equal file1_text, zis.read

      zis.get_next_entry
      assert_equal file2_text, zis.read
    end
  end

  private

  def file1_text
    @file1_text ||= File.read(FILE1)
  end

  def file2_text
    @file2_text ||= File.read(FILE2)
  end
end
