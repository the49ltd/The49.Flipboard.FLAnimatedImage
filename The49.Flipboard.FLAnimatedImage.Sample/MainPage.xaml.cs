using LocalFLAnimatedImage = Flipboard.FLAnimatedImage.FLAnimatedImage;
using FLAnimatedImageView = Flipboard.FLAnimatedImage.FLAnimatedImageView;
using Foundation;

namespace The49.Flipboard.FLAnimatedImage.Sample;

public partial class MainPage : ContentPage
{
	int count = 0;

	public MainPage()
	{
		InitializeComponent();
	}

	private void OnCounterClicked(object sender, EventArgs e)
	{
		count++;

		if (count == 1)
			CounterBtn.Text = $"Clicked {count} time";
		else
			CounterBtn.Text = $"Clicked {count} times";

		SemanticScreenReader.Announce(CounterBtn.Text);

		var data = NSData.FromUrl(NSUrl.FromString("https://upload.wikimedia.org/wikipedia/commons/2/2c/Rotating_earth_%28large%29.gif"));
		var image = LocalFLAnimatedImage.AnimatedImageWithGIFData(data);

		var imageView = new FLAnimatedImageView();
        imageView.AnimatedImage = image;
        imageView.Frame = new CoreGraphics.CGRect(0.0, 0.0, 100.0, 100.0);

		((UIKit.UIView)target.Handler.PlatformView).AddSubview(imageView);

    }
}


