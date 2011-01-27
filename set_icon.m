#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

int main (int argc, const char * argv[]) {
	int exitCode = 1;
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	NSImage *img = nil;
	NSFileManager *fileManager = [NSFileManager defaultManager];

	switch (argc) {
		case 3: {
			NSString *imagePath = [NSString stringWithUTF8String:argv[2]];

			if (![fileManager fileExistsAtPath:imagePath]) {
				NSLog(@"Image file doesn't exist");
				break;
			}

			img = [[NSImage alloc] initWithContentsOfFile:imagePath];

			if (!img) {
				NSLog(@"Can't read image properly");
				break;
			}
		}
		case 2: {
			NSString *itemPath = [NSString stringWithUTF8String:argv[1]];

			if (![fileManager fileExistsAtPath:itemPath]) {
				NSLog(@"File to set icon on doesn't exist");
				break;
			}

			if ([[NSWorkspace sharedWorkspace] setIcon:img forFile:itemPath options:0]) {
				exitCode = 0;
			} else {
				NSLog(@"Can't set icon");
				exitCode = 1;
			}

			break;
		}
		default: {
			printf("set_icon file img - set icon\n");
			printf("set_icon file - delete icon\n");
			break;
		}
	}

	[pool drain];
	return exitCode;
}
