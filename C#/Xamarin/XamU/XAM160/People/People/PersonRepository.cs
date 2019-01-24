using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using People.Models;
using SQLite;

namespace People
{
    public class PersonRepository
    {
        SQLiteConnection conn;
        SQLiteAsyncConnection connAsync;
        public string StatusMessage { get; set; }

        public PersonRepository(string dbPath, bool isAsync)
        {
            if (!isAsync)
            {
                conn = new SQLiteConnection(dbPath);
                conn.CreateTable<Person>();
            }
            else
            {
                connAsync = new SQLiteAsyncConnection(dbPath);
                connAsync.CreateTableAsync<Person>().Wait();
            }

        }

        #region Sync

        public void AddNewPerson(string name)
        {
            int result = 0;
            try
            {
                //basic validation to ensure a name was entered
                if (string.IsNullOrEmpty(name))
                {
                    throw new Exception("Valid name required");
                }

                result = conn.Insert(new Person { Name = name });

                StatusMessage = string.Format("{0} record(s) added [Name: {1})", result, name);
            }
            catch (SQLiteException e)
            {
                if (e.Message.Equals("Constraint"))
                {
                    StatusMessage = "Constraint exception : name of new person must be unique";
                }
                else
                {
                    StatusMessage = $"Failed to add {name}. Error: {e.Message}";
                }
            }
            catch (Exception ex)
            {
                StatusMessage = string.Format("Failed to add {0}. Error: {1}", name, ex.Message);
            }
        }

        public List<Person> GetAllPeople()
        {
            try
            {
                return conn.Table<Person>().ToList();
            }
            catch (Exception ex)
            {
                StatusMessage = string.Format("Failed to retrieve data. {0}", ex.Message);
            }

            return new List<Person>();
        }

        public int DeletePerson(int id)
        {
            return conn.Delete<Person>(id);//returns the number of rows deleted
        }

        #endregion

        #region Async

        public async Task AddNewPersonAsync(string name)
        {
            int result = 0;
            try
            {
                //basic validation to ensure a name was entered
                if (string.IsNullOrEmpty(name))
                {
                    throw new Exception("Valid name required");
                }

                result = await connAsync.InsertAsync(new Person { Name = name });

                StatusMessage = string.Format("{0} record(s) added [Name: {1})", result, name);
            }
            catch (SQLiteException e)
            {
                if (e.Message.Equals("Constraint"))
                {
                    StatusMessage = "Constraint exception : name of new person must be unique";
                }
                else
                {
                    StatusMessage = $"Failed to add {name}. Error: {e.Message}";
                }
            }
            catch (Exception ex)
            {
                StatusMessage = string.Format("Failed to add {0}. Error: {1}", name, ex.Message);
            }
        }

        public async Task<List<Person>> GetAllPeopleAsync()
        {
            try
            {
                var result = await connAsync.Table<Person>().ToListAsync();
                return result;
            }
            catch (Exception ex)
            {
                StatusMessage = string.Format("Failed to retrieve data. {0}", ex.Message);
            }

            return new List<Person>();
        }

        public async Task<int> DeletePersonAsync(int id)
        {
            return await connAsync.DeleteAsync<Person>(id);//returns the number of rows deleted
        }

        #endregion
    }
}