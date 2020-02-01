# frozen_string_literal: true

require 'test_helper'

class ErrorsTest < MiniTest::Test
  def test_bzip2_error
    assert_raises(Zip::Bzip2::Error) do
      raise ::Zip::Bzip2::Error
    end
  end

  def test_bzip2_mem_error
    assert_raises(Zip::Bzip2::Error) do
      raise ::Zip::Bzip2::MemError
    end
  end

  def test_bzip2_data_error
    assert_raises(Zip::Bzip2::Error) do
      raise ::Zip::Bzip2::DataError
    end
  end

  def test_bzip2_magic_data_error
    assert_raises(Zip::Bzip2::Error) do
      raise ::Zip::Bzip2::MagicDataError
    end
  end

  def test_bzip2_config_error
    assert_raises(Zip::Bzip2::Error) do
      raise ::Zip::Bzip2::ConfigError
    end
  end

  def test_bzip2_unexpected_error
    assert_raises(Zip::Bzip2::Error) do
      raise ::Zip::Bzip2::UnexpectedError, -999
    end
  end
end
