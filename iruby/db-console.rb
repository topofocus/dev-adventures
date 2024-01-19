require 'bundler/setup'
ProjectRoot =  Pathname.new( Dir.pwd ).parent
require 'arcade'
#require 'arcade-time-graph'
require 'date'
require 'dry/struct'
require 'iruby'
module Types
  include Dry.Types()
end


class Array

  def method_missing(method, *key)
    unless method == :to_hash || method == :to_str #|| method == :to_int
      return self.map{|x| x.public_send(method, *key)}
    end
  end

  def to_html
    if first.respond_to? :html_attributes
      #title =  first.in_and_out_attributes.keys + html_attributes.keys
      title =  first.html_attributes.keys
      #body = map{|y| y.in_and_out_attributes.values + y.html_attributes.values }
      body = map{|y| y.html_attributes.values }
      IRuby.display IRuby.table [ title ] + body
#      map{|y| IRuby.display IRuby.table y.html_attributes }
    else
      each{|y| IRuby.display IRuby.html y }
    end
  end

  def inspect
  end

end # Array


module Arcade
  class Base
    def inspect
    end
  end
end


 require 'irb'

begin
loader =  Zeitwerk::Loader.new
loader.push_dir ("#{__dir__}/../model")
loader.setup
e = 'd'
IRuby.display IRuby.html "<h2>DEV Adventures</h2>"
IRuby.display IRuby.html "<h3>Jupyter Integration</h3>"
DB = Arcade::Init.connect e
#require 'pry'
require 'irb'

ARGV.clear

rescue  Dry::Struct::Error, Dry::Types::MissingKeyError => e
  ARGV.clear
  puts "Maintance Modus: Please repair the Database"
  puts e.inspect

rescue Psych::SyntaxError => f
  ARGV.clear
  IRuby.display IRuby.html "<hr><h1 style=\"color: red;\">Error in config.yml !</h1><br><h2>Please check and restart kernel</h2> "
end
