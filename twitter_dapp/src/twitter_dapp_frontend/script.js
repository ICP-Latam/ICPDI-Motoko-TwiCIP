const backend = window.ic.plug.getAgent().canister("my_backend_canister_id");

async function postTweet() {
    const author = document.getElementById("author").value;
    const content = document.getElementById("content").value;
    await backend.postTweet(author, content);
    fetchTweets();
}

async function fetchTweets() {
    const tweets = await backend.getTweets();
    const tweetsList = document.getElementById("tweetsList");
    tweetsList.innerHTML = '';
    tweets.forEach(tweet => {
        const li = document.createElement('li');
        li.textContent = `${tweet.author}: ${tweet.content}`;
        tweetsList.appendChild(li);
    });
}

fetchTweets();
