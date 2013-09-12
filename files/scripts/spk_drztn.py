from voiceid.fm import file2trim #seg2trim
import sys

audio = str(sys.argv[1])

#Take a video or audio file and converts it into smaller waves according to the diarization process
file2trim(audio + ".wav")
