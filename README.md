# RandomPixelArt
A tool that generate pixel art randomly using [perlin noise](https://en.wikipedia.org/wiki/Perlin_noise).
![image](https://user-images.githubusercontent.com/83043568/226149370-86d98529-1bab-4708-aad1-53920dc3d434.png)

## Usage
1. Set generator parameters.
2. Press "Generate" button.
3. Right-click your favorite image to save.

## Generator parameters
- **Quantity**  
  The number of images to be generated.
- **Width/Height** (1x1~256x256)  
  The size of image.
- **Symmetry**  
  - None: Generates asymmetric images.
  - Horizontal: Generates horizontally symmetric images.
  - Diagonal: Generates diagonally symmetric images.
- **Noise frequency** (0.01~1)  
  Affects the complexity of the generated images. Larger value will result in more complicated images.
- **Weight** (0~100)  
  The (approximate) percentage of pixels of each color.
