// Dennis Hou 2016
// s3471480 @ RMIT

/*
 *
 *   Assembly.app
 *
 */


This app fetches and shows you the most popular upcoming events around you.






Technical Functionalities:

1) User login/logout + Registration with CoreData (along with unique username requests)
2) Async REST / JSON data fetching from Meetup.com (with ActivityIndicator for UX purposes)
3) Event date, time, and duration in Event Details view ("From" <time> if event duration not given)
4) Dynamic event location details (Displays "Venue not publicly available" if event venue is privated)
5) If event location/venue is public, Google Maps is shown with user's current location + event location
    and a button for showing Directions to venue in Google Maps.
6) Decoded HTML5 content into Label as Event Description.
7) Sharing Event to Twitter, Mail, and Safari.



Notes:
1) Due to Meetup's policy on creating events (you have to pay ~$15 a month to post an event), the "Post an Event" will not work, however the form works.

2) Event Saving and Profile Detail Editing functionalities will be implemented AFTER the semester, hence it is blank at the moment.

3) Meetup does NOT store upcoming event photos, hence the cover photo repetition.

4) Tutorials/Guides/References for codes are noted at the top of the respective files.
