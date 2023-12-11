module Arcade
  class  Account  < Arcade::Vertex
    attribute :name, Types::Nominal::String
    attribute :mail, Types::Nominal::String
   
    def self.db_init
      File.read(__FILE__).gsub(/.*__END__/m, '')
    end
  end
end
__END__
CREATE PROPERTY account.name STRING
CREATE INDEX  ON account (name) UNIQUE
