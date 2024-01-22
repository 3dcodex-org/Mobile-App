import React from 'react';
import { Alert, Button, View } from 'react-native';

export default function SpyCam() {
  const handlePress = () => {
    Alert.alert(
      'Alert Title',
      'My Alert Msg',
      [
        {text: 'OK', onPress: () => console.log('OK Pressed')},
      ],
      { cancelable: false }
    );
  };

  return (
    <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
      <Button title="Trigger Alert" onPress={handlePress} />
    </View>
  );
}