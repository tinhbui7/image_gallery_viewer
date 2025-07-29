# Image Gallery Viewer

A Flutter widget to display a main image with small image indicators below, similar to e-commerce product previews.

## Features

- Tap to change main image
- Smooth scroll of indicators
- Customizable

## Usage

```dart
ImageGalleryViewer(
  images: [
    NetworkImage('https://...'),
    AssetImage('assets/image2.png'),
  ],
)
