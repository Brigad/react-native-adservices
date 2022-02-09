import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-adservices' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo managed workflow\n';

const RNAdServices = NativeModules.RNAdServices
  ? NativeModules.RNAdServices
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

export type AdServicesResponseData = {
  attribution: boolean;
  orgId: number;
  campaignId: number;
  conversionType: string;
  clickDate?: string;
  adGroupId: number;
  countryOrRegion: string;
  keywordId: number;
  adId: number;
};

export function getAttributionToken(): Promise<string | null> {
  return RNAdServices.getAttributionToken();
}

export function getAttributionData(
  token: string
): Promise<AdServicesResponseData | null> {
  return RNAdServices.getAttributionData(token);
}
