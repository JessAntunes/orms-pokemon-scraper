class Pokemon
    attr_accessor :name, :type, :db, :id
    

    def initialize(id: nil, name:, type:, db: )
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.save(pk_name, pk_type, db)
        sql = <<-SQL
          INSERT INTO pokemon (name, type) 
          VALUES (?, ?)
        SQL

        name = pk_name
        type = pk_type
        

        db.execute(sql, name, type)
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.find(id, db)
        sql = "SELECT * FROM pokemon WHERE id = ?"
        
        result = db.execute(sql, id)[0]  
        new_pokemon = Pokemon.new(id: id, name: result[1], type: result[2], db: db)
        new_pokemon
    end

end