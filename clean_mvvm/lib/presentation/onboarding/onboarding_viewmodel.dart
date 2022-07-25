import 'dart:async';

import 'package:clean_mvvm/domain/model.dart';
import 'package:clean_mvvm/presentation/base/baseviewmodel.dart';

import '../resources/assets_manager.dart';
import '../resources/strings_manager.dart';

class OnboardingViewModel extends BaseViewModel
    with OnboardingViewModelInputs, OnboardingViewModelOututs {
  late final List<SliderObject> _list;

  int _currentIndex = 0;
  // stream controllers
  final StreamController _streamController =
      StreamController<SlideViewObject>();

  //inputs
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    // send this slider data to view
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = _currentIndex++;
    if (nextIndex >= _list.length) {
      _currentIndex = 0;
    }
    return _currentIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = _currentIndex--;
    if (previousIndex == -1) {
      _currentIndex = _list.length - 1;
    }
    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  // Output
  @override
  Stream<SlideViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderObject) => sliderObject);

  // private
  List<SliderObject> _getSliderData() => [
        SliderObject(AppStrings.onboardingTitle1,
            AppStrings.onboardingSubTitle1, ImageAssets.onboardingLogo1),
        SliderObject(AppStrings.onboardingTitle2,
            AppStrings.onboardingSubTitle2, ImageAssets.onboardingLogo2),
        SliderObject(AppStrings.onboardingTitle3,
            AppStrings.onboardingSubTitle3, ImageAssets.onboardingLogo3),
        SliderObject(AppStrings.onboardingTitle4,
            AppStrings.onboardingSubTitle4, ImageAssets.onboardingLogo4)
      ];

  _postDataToView() {
    inputSliderViewObject.add(
        SlideViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }
}

// vm will receive from view
abstract class OnboardingViewModelInputs {
  void goNext(); // user clicks on right arrow or swipes left
  void goPrevious(); // user click on left arrow or swipes right
  void onPageChanged(int index);

  Sink
      get inputSliderViewObject; // way to add data to the stream, i.e. stream input
}

// data or result sent from vm to view
abstract class OnboardingViewModelOututs {
  Stream<SlideViewObject> get outputSliderViewObject;
}

class SlideViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SlideViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}
