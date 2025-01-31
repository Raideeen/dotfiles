import json
import random
import sys

import emoji

emoji.config.demojize_keep_zwj
full_emoji_list = emoji.EMOJI_DATA
emoji_list = [
    # Nature emojis
    "🌳",
    "🌲",
    "🌴",
    "🌵",
    "🍄",
    "🌸",
    "🌺",
    "🌻",
    "🌹",
    "🌷",
    "🌿",
    "🍃",
    "🍂",
    "🍁",
    "🌱",
    "🎋",
    "🌾",
    "🌺",
    "🌎",
    "🌍",
    "🌏",
    "🌙",
    "⭐",
    "🌟",
    "☀️",
    "🌤️",
    "🌈",
    "⛈️",
    "❄️",
    "🌊",
    "🦋",
    "🐝",
    "🐞",
    "🦜",
    "🦚",
    # Expressions and Emotions
    "😮",  # shocked/surprised
    "😱",  # screaming in fear
    "😨",  # fearful
    "😎",  # cool with sunglasses
    "🤩",  # star-struck
    "😍",  # heart eyes
    "🥳",  # partying face
    "😄",  # grinning with smiling eyes
    "🤯",  # mind blown
    "😲",  # astonished
    "🫢",  # face with open eyes and hand over mouth
    "😵",  # dizzy face
    "🤪",  # zany face
    "😅",  # grinning face with sweat
    "😂",  # face with tears of joy
    "🥹",  # face holding back tears
    "😭",  # loudly crying face
    "🫣",  # peeking eye
    "🤔",  # thinking face
    "🤨",  # face with raised eyebrow
    "😏",  # smirking face
    "😌",  # relieved face
    "🤤",  # drooling face
    "😴",  # sleeping face
    "🥴",  # woozy face
    "🤓",  # nerd face
    "🧐",  # face with monocle
    "🤖",  # robot face
    "👻",  # ghost
    "😈",  # smiling face with horns
]


def getRandomEmoji():
    emoji = random.choice(list(emoji_list.keys()))
    return json.dumps(
        {"text": emoji, "tooltip": "Random Emoji", "class": "custom-emoji"}
    )


def getRandomEmojiFromList():
    emoji = random.choice(emoji_list)
    return json.dumps(
        {"text": emoji, "tooltip": "Random Emoji", "class": "custom-emoji"}
    )


if __name__ == "__main__":
    print(getRandomEmojiFromList())
    sys.stdout.flush()
