# RailRider

<img src="https://willsploit.s3.amazonaws.com/railrider-proto.png" width=200 />

App to assist with train hopping

## Features
* Detect nearest railway to user
* View freight train routes [wip]
* Display a map and alert user of upcoming:
  * crossings
  * yards [wip]
  * close parallel streets [wip]
* Display speed and track speed limits
* more features coming soon...

Uses OpenStreetMap's Overpass API for querying railroad data and Apple Maps for display. My temporary backend for this is [RailRiderAPI](https://github.com/frillweeman/RailRiderAPI), but it will eventually be broken out into Lambdas.
