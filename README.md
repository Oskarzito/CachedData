# CachedData

CachedData is an app that fetches data from the [JSON Placeholder](https://jsonplaceholder.typicode.com/) API and displays it in a list. 
Tapping an item in the list presents an item detail view. 

## Features

Since the app displays data that's composed from Lorem Ipsum, it might be hard to derive what's what. See images for clarification :)

The data displayed in the app are posts representing posts like the ones found on social media. Clicking on a post shows the posts title on top, its body/content in the middle, and thereafter a list of comments associated with the specific post.

Data is cached in the app and stored to UserDefaults. If internet connection is lost, the app can still load _previously fetched data_. 
NSCache was deliberately not used due to it being an in-memory cache that won't persist between executions.

Overview:

<img src="https://github.com/user-attachments/assets/0a6dbc68-e337-4d87-ad14-8261c410fd10" width=25% height=25%>

Details:

<img src="https://github.com/user-attachments/assets/39e0e37a-768d-4ff9-9006-932a36d1468a" width=25% height=25%>
