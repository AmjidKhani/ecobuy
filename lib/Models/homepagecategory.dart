class CategoryImages
{
  String? title;
  String? images;
  CategoryImages({
    this.title,
    this.images
  });
}
List<CategoryImages> categories=[
CategoryImages(title: 'Grocery', images: 'assets/c_images/grocery.png'),
  CategoryImages(title: 'Cosmetic', images: 'assets/c_images/cosmatics.png'),
  CategoryImages(title: 'Germents', images: 'assets/c_images/garments.png'),
  CategoryImages(title: 'Pharmacy', images: 'assets/c_images/pharmacy.png'),
  CategoryImages(title: 'Electronic', images: 'assets/c_images/electronics.png'),
];