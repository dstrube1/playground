using SQLite;

namespace People.Models
{
    [Table("people")]
    public class Person
    {
        [PrimaryKey, AutoIncrement,Column("_id")]
        //Once the primary key is set, running this app again with the column name commented out will throw an error.
        //Specifically, the error is thrown because of this part of PersonRepository:
        //conn.CreateTable<Person>();
        public int Id { get; set; }
        [MaxLength(250), Unique]
        public string Name { get; set; } 
        //Unique is automatically enforced, but this max length thing doesn't really seem to work.
        //For example, try adding a new person with this name (length = ~438):
        //1234567890 1234567890 1234567890 1234567890 1234567890 1234567890 1234567890 1234567890 1234567890 1234567890 1234567890 1234567890 1234567890 1234567890 1234567890 1234567890 1234567890 1234567890 1234567890 12345678901234567890 1234567890 1234567890 1234567890 1234567890 1234567890 1234567890 1234567890 1234567890 1234567890 1234567890 1234567890 1234567890 1234567890 1234567890 1234567890 1234567890 1234567890 1234567890 1234567890
    }
}
