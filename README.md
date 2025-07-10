
# TMDB iOS App

I created an application that fetches a list of either the week's or the day's trending movies, along with a movie details page and a feature to like movies.


## How to set up

Simply load up xCode and import the provided folder, make sure you unzip it. After you have succesfully imported it you will need to set up your API key. Go to the top tab and click product and hover over scheme and click edit scheme. Then once you are in there, make sure you are in the run tab on the left. Then click arguments and in the enviroment variable section add API_KEY as the key and the value as the API key you have for TMDB. After than press command + B to build. You should now be able to run the application with either an emulator or physical device now. IMPORTANT: Make sure to run it off Xcode as you need it to be running with the API_KEY enviornment variable.



## Code Overview
I used SwiftUI with a MVVM approach, where I also implemented TMDB API calls and image caching. I also followed the requirments of the assignment, meaning I have 4 screens, the list view, the details page, the favorites page, and the settings page. I have provided a video of me demoing the app.
## API Calls and Error Handling
There are two main api calls I make. One is the get trending movies with pagination. The other is getting movie by id. The trending movies calls are made on the movies tab and the next page is called when reaching the end of the LazyHStack and seeing the progress wheel at the end (Lazy Loading). The fetch singular movie call is made when you transition to the details screen. As a side note this was a requirment of the assignment. If it were not I would have just passed in the movie object I got from the main list screen to the details screen as that had all the information I needed, minus genre names which you can get with a seprate api call once, and would reduce API calls.

I have also set up logic to handle common erros such as invalidEndpoint, invalidResponse, noData, serializationError, apiError.

If the user encounters an error there will be a retry button followed by a description of what happened.

## Caching
To improve perfomance and memeory of the app I had to implment a LazyHStack that has mutliple cached async images, look at the cached folder for that implementation. This is to ensure that the user doesnt have to reload a URL image from scratch when navigating the horizontal scroll view. The reason of using the LazyHStack is to save as much memory as possible and not have every poster drawn in the background when off screen.

## Persistent Storage
I simply used the FileManager and made a file called Liked Movies.json that stores a list of movie objects the user likes. This will be loaded when the user is on the favorites tab.
