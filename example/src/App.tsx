/* eslint-disable react-native/no-inline-styles */
import * as React from 'react';

import { View, Text } from 'react-native';
import {
  getAttributionToken,
  getAttributionData,
  AdServicesResponseData,
} from '@brigad/react-native-adservices';

export default function App() {
  const [token, setToken] = React.useState<string | null>(null);
  const [attributionData, setAttributionData] =
    React.useState<AdServicesResponseData | null>(null);

  React.useEffect(() => {
    getAttributionToken().then(setToken);
  }, []);

  React.useEffect(() => {
    if (token) {
      getAttributionData(token).then(setAttributionData);
    }
  }, [token]);

  return (
    <View
      style={{
        flex: 1,
        alignItems: 'center',
        justifyContent: 'center',
        backgroundColor: '#EEE',
      }}
    >
      <View style={{ padding: 16, borderRadius: 8, backgroundColor: 'white' }}>
        {attributionData &&
          Object.keys(attributionData).map((key) => (
            <Text key={key} style={{ textAlign: 'center', paddingVertical: 4 }}>
              {`${key}: ${
                attributionData[key as keyof AdServicesResponseData]
              }`}
            </Text>
          ))}
      </View>
    </View>
  );
}
