# -*- encoding: utf-8 -*-

require './spec/helper'

describe ConsoleFormatter do
  
  it "must respond to format" do
    formatter = ConsoleFormatter.new(COVERAGE_90, ['a', 'b', 'c'])
    formatter.respond_to?(:format).should == true
  end
  
  it "must return percents and filename" do
    formatter = ConsoleFormatter.new(COVERAGE_80, [])
    result = formatter.format
    result.should == "\e[33m80% the/filename/80\e[0m"
  end
  
  it "must return percents and filename and uncovered" do
    formatter = ConsoleFormatter.new(COVERAGE_80, ['a'])
    result = formatter.format
    result.should == "\e[31m0% a\e[0m\n" +
                     "\e[33m80% the/filename/80\e[0m"
  end
  
  it "must sort by percentage" do
    formatter = ConsoleFormatter.new(COVERAGE_100_90_80, [])
    result = formatter.format
    result.should == "\e[33m80% the/filename/80\e[0m\n" +
                     "\e[33m90% the/filename/90\e[0m\n" +
                     "\e[33m100% the/filename/100\e[0m"
  end
  
  it "must sort by percentage uncovered too" do
    formatter = ConsoleFormatter.new(COVERAGE_100_90_80, ['a', 'b'])
    result = formatter.format
    result.should == "\e[31m0% a\e[0m\n" +
                     "\e[31m0% b\e[0m\n" +
                     "\e[33m80% the/filename/80\e[0m\n" +
                     "\e[33m90% the/filename/90\e[0m\n" +
                     "\e[33m100% the/filename/100\e[0m"
  end
  
end

describe HtmlFormatter do

  it "must respond to format" do
    formatter = HtmlFormatter.new COVERAGE_70
    formatter.respond_to?(:format).should == true
  end
  
  it "must return the right number of html file(s)" do
    formatter = HtmlFormatter.new COVERAGE_30_70
    result = formatter.format
    result.size.should == 2
  end
  
  it "must return html file(s)" do
    formatter = HtmlFormatter.new COVERAGE_70
    result = formatter.format
    result.each {|k, v| v.start_with?('<html>').should == true }
  end
  
  # Bug 13
  it "must produce html entities for < and >" do
    file = File.join($COCO_PATH, 'spec/project/html_entities.rb')
    coverage = {file => [1, 1, 0, nil, 1, 1, nil, nil]}
    formatter = HtmlFormatter.new coverage
    result = formatter.format[file]
    result.match(/a &lt; b<\/pre><\/td>/).should_not == nil
    result.match(/a &gt; b<\/pre><\/td>/).should_not == nil
  end
  
end

describe HtmlIndexFormatter do
  it "must respond to format" do
    formatter = HtmlIndexFormatter.new(COVERAGE_30_70, [])
    formatter.respond_to?(:format).should == true
  end
  
  it "must build the index.html" do
    formatter = HtmlIndexFormatter.new(COVERAGE_30_70, [])
    formatter.format.start_with?('<html>').should == true
  end
end

describe ColoredString do
  it "must act as a string" do
    instance = ColoredString.new
    instance.kind_of?(String).should == true
  end
  
  it "must accept a string on instanciation" do
    instance = ColoredString.new 'azerty'
    instance.should == 'azerty'
  end
  
  it "must redify a string" do
    string = ColoredString.new 'azerty'
    string.red.should == "\e[31mazerty\e[0m"
  end
  
  it "must yellowify a string" do
    string = ColoredString.new 'azerty'
    string.yellow.should == "\e[33mazerty\e[0m"
  end
end
