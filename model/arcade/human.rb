module Arcade
  class  Human  < Arcade::Vertex
    attribute :name, Types::Nominal::String

    def self.db_init
      File.read(__FILE__).gsub(/.*__END__/m, '')
    end
  end
end
__END__
CREATE PROPERTY human name STRING
CREATE INDEX  ON human( name ) UNIQUE
