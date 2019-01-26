# A wine recommending application


| **Team Members** |
| -- |
| Sreya Guha |
| Simran Sethi |

**Written Feedback**

We provided feedback to two groups in class. This feedback session gave us an opprtunity to look at other R Shiny applications for a variety of different problems and understand and appreciate the usefulness of the applications. The links to the feedbacks are provided below : 

- [Feedback for Mental-Health-Analysis_Vis-App](https://github.com/UBC-MDS/Mental-Health-Analysis_Vis-App/issues/27)

- [Feedback for college_scorecard](https://github.com/UBC-MDS/college_scorecard/issues/15)

**Usefulness of the feedback we recieved**

Our first plot was made to visualize the relationship between price and rating for each country sampled from the data set. This was a fairly intuitive plot and was well appreciated by our peers. This also provided us with a fairly obvious but funny revelation that higher-priced wines do tend to have higher ratings. 

Another feature that we had provided is the world map that allows the user to see the median price and rating of the country that he/she has selected by hovering on the map. This feature was also well recieved by the reviewers. A misunderstanding that was pointed out by the TA with the world map plot was that since it was included in the same page as the filters, users expected it to change with the filter selection. Since the world map showed an overall view of the wine rating and prices across the globe it would not make sense for it to change with the user input. We thus decided to move it to a new tab for convinence. This however caused our application load time to be extremely long and thus we let go of that and decided to put in a disclaimer regarding this in the information page instead.

The third feature in our app was a word cloud to check the most commonly used words that have been used to describe the wine. The wordcloud can be filtered based on the type of wine, price, etc. This was also very well recieved by our peers and was stated as being very helpful and an intuitive feature that helps the cause of the dashboard.

However, both the word cloud and the scatter plot had some issues. Both the plots did not work unless the correct province was selcted along with the countries they were mapped to. We failed to mention the neccesity to slect the correct province along with the country and this created some confusion. We have fixed these issues in our current release of the application and it seems to function properly now. 

The consistent problem that both groups of reviewers faced was that of the load time of the application. After investigation, we figured that the delay in the load of the app was caused by our world map. However due to the lack of time we could not come up with an efficient way to solve the issue. We did manage to reduce our data set by an appropriate number which would not harm our analysis. This lead to the load time to reduce by some amount but did not make it as fast as we would have liked it to be.

I found the "fly-on-the-wall" experience very helpful. This helped me get an insight into how people percieve our application without us telling them how to use it. It gives us an idea about how intuitive and user friendly our application is. It measures the usability of the application from a different point of view. This process helped us identify flaws that we didn'realise the application as we had been working on it for a while. Certain features and functionalities that were evident to us as the designers of the application were not very clear to the users. This session helped us a lot in making our app more user friendly.

**Project change since Milestone 2**

The most common and pressing problem put forward by our peers and the TA(s) was the load time of our application. This we realised was due to the world map functionality that we had included in our application. We did try a few methods to reduce the time it takes to load the application by trying different methods to make the world map work faster. However, due to the short time span we had to fix this issue, we could not come up with an efficient solution to the problem. We did make a quick fix by reducing our data set to make the application load faster than the one we presented in milestone 2.

Our objective and target audience for the application remains the same. Although we did make several changes to the application to make it more user friendly and intuitive.

It was also pointed out in one of our reviews that the world map functionality on the main page does not change with the user inputs. This made us realise that since the world map appears on the main page along with the other plots that do change with the user outputs, users expect the world map to change too. We believe that this was indeed a design flaw in our application. We did make an attempt to create a separate tab for the world map but that proved to be very expensive in terms of the app load time.

**Tasks for the upcoming milestone**

The description column in our "data" tab is too long for some reviews which is unpleasant to the eyes. We will try to make the decsription column shorter so that the data table is more appealing to the eyes.

We also aim at adding a upload button to the application "data" page so that users can upload their own data and use the layout of our app to analyse their own data.
