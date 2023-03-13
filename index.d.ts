export interface TextDetectorBounding {
  width: number;
  height: number;
  left: number;
  top: number;
}

export interface TextDetectorResponse {
  text: string;
  bounding: TextDetectorBounding;
}

declare class TextDetector {
  static detectFromUri(uri: string, lang: string): Promise<TextDetectorResponse[]>;
}

export default TextDetector;
