import speech_recognition as sr
print("Buscando microfonos")
mics= sr.Microphone.list_microphone_names()
for i, nombre in enumerate(mics):
    print(f"indice{i}:{nombre}")
    