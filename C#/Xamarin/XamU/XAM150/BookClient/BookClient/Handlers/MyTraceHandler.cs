using System.Diagnostics;
using System.Net.Http;
using System.Threading;
using System.Threading.Tasks;

namespace BookClient.Handlers
{
    public class MyTraceHandler : DelegatingHandler
    {
        bool hasOutputNonLastMessageDebugMessage;
        //from about 4 min here:
        //https://elearning.xamarin.com/forms/xam150/4-integrating-with-the-platform/
        //Note, that video doesn't have enough info for this to be testable
        public MyTraceHandler(HttpMessageHandler inner) : base(inner)//DelegatingHandler implements pipeline
        {
            //Handler is not the last message processing node in the pipeline
            if (!hasOutputNonLastMessageDebugMessage)
            {
                hasOutputNonLastMessageDebugMessage = true;
                Debug.WriteLine("Non last message handled by MyTraceHandler: *&");
            }
            else
            {
                Debug.WriteLine("*&"); //littering and...
            }
        }

        public MyTraceHandler() : this(new HttpClientHandler()) 
        {
            Debug.WriteLine("Last message handled by MyTraceHandler: &*");
        }

        protected override async Task<HttpResponseMessage> SendAsync(HttpRequestMessage request, CancellationToken cancellationToken) 
        {
            Debug.WriteLine($"Request: {request}");
            var response = await base.SendAsync(request, cancellationToken);
            Debug.WriteLine($"Response: {response}");
            return response;
        }
    }
}
