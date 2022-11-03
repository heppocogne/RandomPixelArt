# RandomPixelArt
A tool that generate pixel art randomly using [perlin noise](https://en.wikipedia.org/wiki/Perlin_noise).
![image](https://user-images.githubusercontent.com/83043568/199630623-cb50e26f-721e-472a-9582-ef130a1c78d2.png)

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
- **Simplicity** (0.1~32)  
  Affects the complexity of the generated images. Smaller value will result in more complicated images.
- **Weight** (0~100)  
  The (approximate) percentage of pixels of each color.
