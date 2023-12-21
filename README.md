# nested_navigation


Imperative navigation, where you directly tell the navigator to push or pop 
a route, was the standard way of handling navigation in earlier versions of 
Flutter. It’s straightforward and can be more intuitive for developers coming 
from other frameworks.

However, with the introduction of the new navigation system in Flutter 2.0, the 
focus has shifted towards a more declarative style of navigation. In this style,
you define a list of pages and Flutter takes care of rendering the appropriate
UI based on that list. This approach is more in line with the overall 
philosophy of Flutter, where the UI is a function of state.

The declarative style has several advantages:

   - It’s easier to manage complex navigation states.

   - It works better with Flutter’s hot reload feature, as the navigation state
    is preserved.

   - It’s more consistent with the rest of the Flutter framework.

That being said, the imperative style is not “bad”. It can still be useful in 
certain scenarios and is still supported by Flutter. However, for complex 
applications with nested navigation, modal routes, or deep linking, the 
declarative style can be more maintainable and less error-prone.

In conclusion, whether to use imperative or declarative navigation depends on 
the specific needs of your application. It’s always a good idea to understand 
the strengths and weaknesses of both approaches and choose the one that best 
fits your use case.
