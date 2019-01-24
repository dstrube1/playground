using System;
using System.Diagnostics;
//Adding NuGet packages for this failed until we just used sqlite-net-pcl:
//using System.Data.SQLite;
//Error:
//System.DllNotFoundException has been thrown
//SQLite.Interop.dll not found
//using SQLite;

using Xamarin.Forms;

namespace People
{
    public partial class MainPage : ContentPage
    {
        //public ObservableCollection<Person> peopleO;
        public MainPage()
        {
            InitializeComponent();
        }

        //public int AddPerson(string name)
        //{
        //    var person = new Person
        //    {
        //        Name = name
        //    };
        //    try
        //    {
        //        var result = connection.Insert(person);
        //        return result;
        //    }
        //    catch (SQLiteException e)
        //    {
        //        Debug.WriteLine("Caught SQLiteException; super helpful message: " + e.Message);//-_-
        //        Debug.WriteLine("Constraint exception : name of new person must be unique");

        //        return 0;
        //    }
        //}

        public async void OnNewButtonClicked(object sender, EventArgs args)
        {
            statusMessage.Text = "";

            if (!App.IsAsync)
            {
                App.PersonRepo.AddNewPerson(newPerson.Text);
            }
            else
            {
                await App.PersonRepo.AddNewPersonAsync(newPerson.Text);
                statusMessage.Text = App.PersonRepo.StatusMessage;
            }
        }

        public async void OnGetButtonClicked(object sender, EventArgs args)
        {
            statusMessage.Text = "";

            if (!App.IsAsync)
            {
                var people = App.PersonRepo.GetAllPeople();
                peopleList.ItemsSource = people;
                foreach (var person in people)
                {
                    Debug.WriteLine($"person id: {person.Id} - name: {person.Name}");
                    Debug.WriteLine($"person name length: {person.Name.Length}");
                }
                Debug.WriteLine("Result of deleting person 5: " + App.PersonRepo.DeletePerson(5));
                //Once an id is deleted, adding another row doesn't reuse that id; it skips on to the next
            }
            else
            {
                var people = await App.PersonRepo.GetAllPeopleAsync();
                //peopleO = new ObservableCollection<Person>();
                foreach (var person in people)
                {
                    //peopleO.Add(person);
                    Debug.WriteLine($"person id: {person.Id} - name: {person.Name}");
                    Debug.WriteLine($"person name length: {person.Name.Length}");
                }
                peopleList.ItemsSource = people;

                Debug.WriteLine("Result of deleting person 4: " + await App.PersonRepo.DeletePersonAsync(4));
            }
        }

    }
}