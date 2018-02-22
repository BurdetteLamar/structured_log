require 'test_helper'

class StructuredLogTest < Minitest::Test
  def test_version_exist
    refute_nil ::StructuredLog::VERSION
  end

  # Create a temporary logfile.
  # Caller should provide a block to be executed using the log.
  # Returns the file path to the closed log.
  def create_temp_log
    dir_path = Dir.mktmpdir
    file_path = File.join(dir_path, 'log.xml')
    StructuredLog.open({:file_path => file_path}) do |log|
      yield log
    end
    file_path
  end

  # Helper class for checking logged output.
  class Checker

    attr_accessor \
      :exceptions,
      :file_path,
      :root,
      :test

    # - +test+:  +MiniTest::Test+ object, to make assertions available.
    # - +file_path+:  Path to log file.
    def initialize(test, file_path)
      # Needs the test object for accessing assertions.
      self.test = test
      self.file_path = file_path
      # Clean up after.
      ObjectSpace.define_finalizer(self, method(:finalize))
      File.open(file_path, 'r') do |file|
        self.root = REXML::Document.new(file).root
      end
      nil
    end

    # To clean up the temporary directory.
    # - +object_id+:  Id of temp directory.
    def finalize(object_id)
      file_path = ObjectSpace._id2ref(object_id).file_path
      File.delete(file_path)
      Dir.delete(File.dirname(file_path))
      nil
    end

    def assert_root_name(name)
      test.assert_equal(name, self.root.name)
    end

    def assert_xml_indentation(indentation)
      File.open(file_path) do |file|
        lines = file.readlines
        case indentation
          when -1
            # Should all be on one line; no whitespace.
            test.assert_equal(1, lines.size)
          when 0
            # Should be multiple lines, but no indentation.
            test.assert_operator(1, :<, lines.size)
            test.refute_match(/^ /, lines[1])
          when 2
            # Should be multiple lines, with 2-space indentation.
            test.assert_operator(1, :<, lines.size)
            test.assert_match(/^  \S/, lines[1])
          else
            raise NotImplementedError(indentation)
        end
      end
    end

  end

  def test_new
    exception = assert_raises(RuntimeError) do
      StructuredLog.new
    end
    assert_equal(StructuredLog::NO_NEW_MSG, exception.message)
  end

  def test_open_no_block
    exception = assert_raises(RuntimeError) do
      StructuredLog.open
    end
    assert_equal(StructuredLog::NO_BLOCK_GIVEN_MSG, exception.message)
  end

  def test_open_block
    file_path = StructuredLog.open do |_|
    end
    Checker.new(self, file_path)
  end

  def test_open_default_file_path
    file_path = StructuredLog.open do |log|
      assert_equal('./log.xml', log.file_path)
    end
    Checker.new(self, file_path)
  end

  def test_open_file_path
    file_path = StructuredLog.open(:file_path => 'foo.xml') do |log|
      assert_equal('foo.xml', log.file_path)
    end
    Checker.new(self, file_path)
  end

  def test_open_root_name
    root_name = 'foo'
    file_path = StructuredLog.open(:root_name => root_name) do |_|
    end
    checker = Checker.new(self, file_path)
    checker.assert_root_name(root_name)
  end

  def test_open_xml_indentation
    [-1, 0, 2].each do |indentation|
      file_path = StructuredLog.open(:xml_indentation => indentation) do |log|
        log.section('Section') do
        end
      end
      checker = Checker.new(self, file_path)
      checker.assert_xml_indentation(indentation)
    end

  end

  def test_section

  end

  def test_put_element

  end

  def test_comment

  end

end
