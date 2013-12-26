require File.expand_path(File.dirname(__FILE__) + '/lib/peterhenrikson')

run PH::App

DB.disconnect
