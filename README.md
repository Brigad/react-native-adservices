# react-native-adservices

AdServices React Native Wrapper

## Installation

```sh
yarn add @brigad/react-native-adservices
```

## Usage

```js
import { getAttributionToken, getAttributionData } from "@brigad/react-native-adservices";

// ...

const attributionToken = await getAttributionToken();
const attributionData = await getAttributionData(attributionToken);
```

See [Apple Docs](https://developer.apple.com/documentation/ad_services/aaattribution/3697093-attributiontoken)

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT
