abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  // shared variables and functions that will be used through any viewmodel

}

abstract class BaseViewModelInputs {
  void start(); // called while init of vm
  void dispose(); // called when vm lifecycle is over
}

abstract class BaseViewModelOutputs {}
