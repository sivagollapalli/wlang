# Installs a rake task for for running unit tests.
#
# This file installs the 'rake unit_test' and extends 'rake test' to run unit 
# tests, if any. It is automatically generated by Noe from your .noespec file, 
# and should therefore be configured there, under the variables/rake_tasks/unit_test 
# entry, as illustrated below:
#
# variables:
#   rake_tasks:
#     unit_test:
#       pattern: test/test*.rb
#       verbose: false
#       warning: false
#       ...
#
# If you have specific needs requiring manual intervention on this file, 
# don't forget to set safe-override to false in your noe specification:
# 
# template-info:
#   manifest:
#     tasks/unit_test.rake:
#       safe-override: false
#
# More info about the TestTask and its options can be found on 
# http://rake.rubyforge.org/classes/Rake/TestTask.html
#
begin
  require 'rake/testtask'
  desc "Run unit tests"
  Rake::TestTask.new(:unit_test) do |t|

    # List of directories to added to $LOAD_PATH before running the
    # tests. (default is 'lib')
    t.libs = ["lib"]

    # True if verbose test output desired. (default is false)
    t.verbose = false

    # Test options passed to the test suite.  An explicit TESTOPTS=opts 
    # on the command line will override this. (default is NONE)
    t.options = nil

    # Request that the tests be run with the warning flag set.
    # E.g. warning=true implies "ruby -w" used to run the tests.
    t.warning = false

    # Glob pattern to match test files. (default is 'test/test*.rb')
    t.pattern = nil

    # Style of test loader to use.  Options are:
    #
    # * :rake -- Rake provided test loading script (default).
    # * :testrb -- Ruby provided test loading script.
    # * :direct -- Load tests using command line loader.
    # 
    t.loader = :rake

    # Array of commandline options to pass to ruby when running test 
    # loader.
    t.ruby_opts = []

    # Explicitly define the list of test files to be included in a
    # test.  +list+ is expected to be an array of file names (a
    # FileList is acceptable).  If both +pattern+ and +test_files+ are
    # used, then the list of test files is the union of the two.
    t.test_files = ["test/unit/test_all.rb", "test/blackbox/test_all.rb", "test/standard_dialects/test_all.rb", "test/standard_dialects/**/*_test.rb"]

  end
rescue LoadError => ex
  task :unit_test do
    abort 'rspec is not available. In order to run spec, you must: gem install rspec'
  end
ensure
  desc "Run all tests"
  task :test => [:unit_test]
end

