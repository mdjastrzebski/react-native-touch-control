import { useEffect, useState } from 'react';
import {
  FlatList,
  Pressable,
  SafeAreaView,
  StyleSheet,
  Text,
  View,
} from 'react-native';
import { NativeTouchConsumer } from 'react-native-touch-consumer';

const COLOR_DATA = [
  { color: '#ff3b30', name: 'Red' },
  { color: '#ff9500', name: 'Orange' },
  { color: '#ffcc00', name: 'Yellow' },
  { color: '#34c759', name: 'Green' },
  { color: '#00c7be', name: 'Teal' },
  { color: '#30b0c7', name: 'Cyan' },
  { color: '#32ade6', name: 'Light Blue' },
  { color: '#007aff', name: 'Blue' },
  { color: '#5856d6', name: 'Indigo' },
  { color: '#af52de', name: 'Purple' },
  { color: '#ff2d55', name: 'Pink' },
  { color: '#a2845e', name: 'Brown' },
  { color: '#8e8e93', name: 'Gray' },
  { color: '#636366', name: 'Dark Gray' },
  { color: '#1c1c2e', name: 'Ink' },
  { color: '#ff6482', name: 'Rose' },
  { color: '#ffb340', name: 'Amber' },
  { color: '#66d4cf', name: 'Aqua' },
  { color: '#63e6e2', name: 'Mint' },
  { color: '#409cff', name: 'Sky' },
  { color: '#7d7aff', name: 'Periwinkle' },
  { color: '#da8fff', name: 'Lilac' },
  { color: '#ff8cc6', name: 'Blush' },
  { color: '#b59469', name: 'Sand' },
  { color: '#00b894', name: 'Emerald' },
  { color: '#0984e3', name: 'Ocean' },
  { color: '#6c5ce7', name: 'Violet' },
  { color: '#e17055', name: 'Coral' },
  { color: '#fdcb6e', name: 'Butter' },
  { color: '#00cec9', name: 'Turquoise' },
];

const NAV_BUTTONS = ['Left', 'Center', 'Right'] as const;

export default function App() {
  const [message, setMessage] = useState<string | null>(null);

  useEffect(() => {
    if (message === null) {
      return;
    }

    const timeout = setTimeout(() => setMessage(null), 2000);
    return () => clearTimeout(timeout);
  }, [message]);

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.navBar}>
        {NAV_BUTTONS.map((label) => (
          <Pressable
            key={label}
            style={({ pressed }) => [
              styles.navButton,
              pressed && styles.navButtonPressed,
            ]}
            onPress={() => setMessage(`${label} button pressed`)}
          >
            {/*
              These nav buttons sit in the top area that iOS 26 treats as the
              scroll-to-top tap zone. The label lives inside the NativeTouchConsumer
              (a native UIControl), so the control spans the button and claims the
              touch, keeping the system from triggering scroll-to-top on press.
            */}
            <NativeTouchConsumer style={styles.navButtonTouchConsumer}>
              <Text style={styles.navButtonText}>{label}</Text>
            </NativeTouchConsumer>
          </Pressable>
        ))}
      </View>

      <FlatList
        data={COLOR_DATA}
        keyExtractor={(item) => item.name}
        contentContainerStyle={styles.listContent}
        renderItem={({ item }) => (
          <View style={styles.row}>
            <NativeTouchConsumer color={item.color} style={styles.swatch} />
            <Text style={styles.rowText}>{item.name}</Text>
          </View>
        )}
      />

      {message !== null && (
        <View style={styles.snackbar} pointerEvents="none">
          <Text style={styles.snackbarText}>{message}</Text>
        </View>
      )}
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f2f2f7',
  },
  navBar: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    backgroundColor: '#1c1c2e',
  },
  navButton: {
    justifyContent: 'center',
  },
  navButtonTouchConsumer: {
    paddingVertical: 10,
    paddingHorizontal: 16,
    backgroundColor: 'red',
  },
  navButtonPressed: {
    opacity: 0.5,
  },
  navButtonText: {
    color: '#ffffff',
    fontSize: 15,
    fontWeight: '600',
  },
  listContent: {
    padding: 12,
  },
  row: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#ffffff',
    borderRadius: 10,
    paddingVertical: 14,
    paddingHorizontal: 16,
    marginBottom: 10,
  },
  swatch: {
    width: 32,
    height: 32,
    borderRadius: 8,
    marginRight: 16,
  },
  rowText: {
    fontSize: 17,
    color: '#1c1c2e',
  },
  snackbar: {
    position: 'absolute',
    left: 16,
    right: 16,
    bottom: 32,
    backgroundColor: '#1c1c2e',
    borderRadius: 10,
    paddingVertical: 14,
    paddingHorizontal: 18,
  },
  snackbarText: {
    color: '#ffffff',
    fontSize: 15,
    fontWeight: '500',
  },
});
