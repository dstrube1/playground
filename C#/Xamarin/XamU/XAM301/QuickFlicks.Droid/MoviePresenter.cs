using QuickFlicks.Data;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Threading;
using System;

namespace QuickFlicks.Droid
{
    public class MoviePresenter
    {
        //Cancellation token for search optimization:
        //https://elearning.xamarin.com/forms/xam301/2-architect-an-android-app-in-mvp/exercise2/11-optimizing-search
        private CancellationTokenSource cts;

        public event Action<IReadOnlyList<Movie>> FilterApplied;

        public async Task FilterMoviesAsync(string search)
        {
            cts?.Cancel();

            if (!string.IsNullOrEmpty(search))
            {
                var innerToken = cts = new CancellationTokenSource();
                var movieService = new MovieService();
                var movies = await movieService.GetMoviesForSearchAsync(search);

                if (!innerToken.IsCancellationRequested)
                {
                    FilterApplied?.Invoke(movies);
                }
            }
            else
            {
                FilterApplied?.Invoke(null);
            }
        }
    }
}

