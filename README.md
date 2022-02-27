## Inspiration
Tired of 2D photos for visualization and decision making
## What it does
*Stitches 2D photos of an object  into 3D model which is  combined into a interactive augmented reality for critical visualization and decision making for users in remote area*

Client(Seller) iOS application send a group of photos of an object to server
In server the photos are modeled into a 3d Object
3d Object is received by Client(buyer)  and shown in interactive AR environment
3d objects from  different sellers can be viewed simultaneously in single simulation
3D objects can be scaled and moved around and analyzed in 3d View

The app set's platform for buyer and seller via interactive 3D platform.


## How we built it
We build client mobile iOS app in Swift and for interactive augmented models we used RealityKit and ARKit
The 2D to 3D modelling was done through metal graphical Api apple.
Google Cloud Platform and python server are used for interaction between mobile client and server for image and file transfer 

We use google cloud platform app engine and google bucket storage to create api's and store blob data. The GCP api code is available at '/Hackathon Backend'

The APIs serve the data to and from the inbetween components of the infrastructure

![alt text](https://github.com/srirammura/Real-VR/blob/main/Real%20VR%20infrastructure.jpeg)
## Challenges we ran into
Running Graphics Intensive Computation of 2D images into 3D models, 
Creating Interactive Augmented 3D object placement 
Deploying Server for graphical Computation
## Accomplishments that we're proud of

Creating look alike 3d Model and from group of 2d photos
Deploying Several 3D models into one simulation
Deploying server and client interaction in short time 

GCP Bucket storage after the api uploads the bunch of images and after the model (.ucdz) is stored as blob

![alt text](https://github.com/srirammura/Real-VR/blob/main/Screen%20Shot%202021-11-07%20at%209.44.42%20AM.png)

After fetching multiple AR models and when compared :

![alt text](https://github.com/srirammura/Real-VR/blob/main/Car%20comparion%20AR.jpeg)

## What we learned

3D modelling, AR Creation and manipulation, Using GCP to create a clean infrastructure and integrate different elements through cloud,Time Management and Team working

## What's next for RealAR

Real time Interaction between two end users at remote location in augmented environment
