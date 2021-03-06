# eBay Kleinanzeigen Coding Challenge

Congratulations! You made it to the eBay Kleinanzeigen coding challenge. Here, we want to get a taste of your hands-on coding skills as well as your understanding of design and product.

## Background
Since our View Item Page (= VIP) is a bit outdated, we want to re-brush our VIP.


## To Do
Please create a new VIP matching the design (Design.pdf). 
All necessary image assets and colors are already defined.
Use the default system font (e.g. for iOS: San Francisco)

You can use any library or tool. It’s expected to apply an architectural pattern and to provide a well structured code.

### General information:
* See design of the sections in the attached design (sections are separated by a thick grey line)
* Size of sections adapts dynamically according the number of attributes (e.g. “Zimmer”) / contents (e.g. having additional documents such as PDF)
* If there is no content for a section (ex. no uploaded PDF, no attributes for “Ausstattung”, etc.), the section should collapse)

### Section: Images
* Show all the images in a horizontally swipeable gallery
* Show the first picture of the ad by default
* Show the share icon on the top right on the picture
* On the bottom left there is the number of the displayed picture and the number of pictures in total; divided by “/”
the user should be able to swipe through the gallery (Font size: 14, Text color: @color/black, Background color: @color/black_transparent)
* Clicking on an image opens it in a new screen with bigger resolution

### Section: Basic Info (directly below the picture) 
* Ad title (Json key: title)
* Price and currency (Json key: price)
* Address in the format "Street, ZIP Code, City" (it’s a link to google maps with the given latitude and longitude) (Json key: address)
* Calendar icon + creation date (Json key: posted-date-time)
* Views icon + number of visits (Json key: visits)
* Show ‘ID:’ and add Ad-ID (Json key: id)

### Section: Details
* Show headline: ‘Details’
* List all attributes coming from backend and the respective value and unit (Json key: attributes)

### Section: Features (Ausstattung) 
* Show headline ‘Ausstattung’
* List respective features in two columns (Json key: features)
* Keep order of features; logic: left, right, left, right, etc
* Put a green check before every feature in this section (asset provided in drawable folder)

### Section: Documents (PDFs)
* Show headline ‘Weitere Informationen’
* Show PDF icon and Name of PDF and chevron (Json key: documents)
* When the user clicks on a document, the respective PDF opens in a browser

### Section: Description
* Show headline ‘Beschreibung’
* Show the description coming from the backend (Json key: description)

## Technical Details
* You can use any library or tool
* It’s expected to apply an architectural pattern and to provide a well structured code
* The app should request and parse content from our JSON service
* The app should load images from the URL that is part of the response

### API Details
* API endpoint URL: https://gateway.ebay-kleinanzeigen.de/mobile-api/candidate/ads/{ad_id}
* Ad ID to request: 1118635128
* Authorization: Basic Authentication
* Credentials:
  * Username: candidate
  * Password: yx6Xz62y

### Additional Info
* To generate the real image url replace the {imageId} placeholder with the string 1 or 57 accordingly for preview or full size.

Example:
`https://i.ebayimg.com/00/s/NjAwWDgwMA==/z/UhYAAOSweiZf0KEb/$_{imageId}.JPG`
should be converted to
`https://i.ebayimg.com/00/s/NjAwWDgwMA==/z/UhYAAOSweiZf0KEb/$_1.JPG` for preview
and
`https://i.ebayimg.com/00/s/NjAwWDgwMA==/z/UhYAAOSweiZf0KEb/$_57.JPG` for full size image.

### Sample Json Output

**Run this curl command to get the sample data:**

```
curl --basic -u candidate:yx6Xz62y --user-agent "some-user-agent" https://gateway.ebay-kleinanzeigen.de/mobile-api/candidate/ads/1118635128
```

## Final Remarks

* You have 4 hours to complete the challenge.
* If you can’t manage to finish all the details during the given time, no worries! What’s important is how you approach the challenge.
* Please fill out the rest of this README file that explains your approach.
* Once you’re done with the challenge, please zip the project folder, upload it to Google Drive and send us the publicly available link to the zip file on Google Drive.

**Have fun!**


## Your comments / remarks

How did you approach the task?
What architecture-layers did you create and why?
What would you do if you had more time?
Which trade-offs did you take?

* I approached the task using MVVM architecture and Combine to perform the HTTP request. If I had more time I could try using also SfiftUI to develop the UI, as the interface was easy enough to achieve this.
* Also, not all the UI would behave perfectly, it would have taken more time to create appropriate components to cache images, and also place the checker in perfect alignment.
* With more time I wuould have created components for singles pieces of UI, i.e cells
* The trade-offs I took where in UIViewController too much filled with logic, in a proper MVVM more I would have mode other logic, including the cells login into the view model.

It's not great, it works, you wanted 4hrs those are mine 4 hours.
