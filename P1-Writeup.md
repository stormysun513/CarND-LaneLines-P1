# **Finding Lane Lines on the Road** 

---

**Finding Lane Lines on the Road**

The goals / steps of this project are the following:
* Make a pipeline that finds lane lines on the road
* Reflect on your work in a written report


[//]: # (Image References)

[image1]: ./test_images_output/solidWhiteCurve.jpg "Result"

---

### Reflection

### 1. Describe your pipeline. As part of the description, explain how you modified the draw_lines() function.

My pipeline consisted of several steps. Each image was converted to grayscale image first, then apply a gaussian blurring algorithm to reduce high frequency noises. Once I got the blurred image, we can apply the canny edge detection algorithm with vertexes denoting the region of interest. I then apply the hough transform algorithm on images to get a set of line segments. Actual lane lines can be calculated through separation of line segments with different slopes. 

I add a helper funciton called draw_lane_lines() in the notebook. It includes all steps described above and return images with lane drawn on the image. I did not modify the draw_line() function but use this function to derive a better detection of lane lines. The detect_lane_lines() function take output lines returned by the hough transform and the image size and return two lines which represents both left and right lane lines. My approach first distinguish lines based on their slope. A positive slope is classified into left part while negative one is classified in to right part. The actual slope I use is the average of all slopes in each set. The coordinate of one end is then calculated based on the characteristic of images from the camera. Most of the lanes converges at the vanish point at the middle of the image. Therefore, I assume that one of the end point of lane lines is close to the middle of image. I iterate through all line segments to find the closest point at each set.

Th following image is one of the output results.

![alt text][image1]


### 2. Identify potential shortcomings with your current pipeline

The current pipeline includes region of interest identification. I roughly apply a traingle mask at the bottom of the image. It restrict the hough transform algorithm from search irrelevent lines in the image which improve the accuracy to some extents. However, it has limitations. The road may not be straight and the driver may not always drive at the middle of the lane. If there is offset from the middle of the lane the detection algorithm may capture some irrelevent lines while calculating the average. 

Besides, one may notice that the average approach only is not robust enough. When the lane line is far from the camera. It contribute less information compared to the close one. The detection result on the side that line is not continuous tends to drift in the video.


### 3. Suggest possible improvements to your pipeline

To further improve the algorithm, we can make advantage of infomation of vanish point in the image. The current version of algorithm use average only and the closest points at the middle as the end point. It is very sensitive to edge noise. What we can do is to vote the vanish point and calibrate the end points on the lane line to avoid drifting.