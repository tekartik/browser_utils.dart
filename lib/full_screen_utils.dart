/// Browser full screen helpers (web only, the stub throws elsewhere).
///
/// [requestFullScreen] and [exitFullScreen] return futures that complete once
/// the browser applied the change; [isFullScreen] reads the document state and
/// [onFullScreenChange] reports every change, asked for or not (escape).
library;

export 'src/platform/platform.dart'
    show
        requestFullScreen,
        exitFullScreen,
        isFullScreen,
        isFullScreenSupported,
        onFullScreenChange;
