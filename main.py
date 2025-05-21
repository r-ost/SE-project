import sys
import os
from PyQt5.QtWidgets import (
    QApplication, QWidget, QVBoxLayout, QHBoxLayout, QLabel, QPushButton, QScrollArea
)
from PyQt5.QtCore import Qt, QTimer
from pyswip import Prolog

_rent = [
    "Czy szukasz mieszkania dla studenta (małe, blisko centrum)?",
    "Czy szukasz mieszkania dla rodziny na wynajem?",
    "Czy potrzebujesz mieszkania dostosowanego dla seniora?",
    "Czy interesują Cię mieszkania nowe (po 2010 roku)?",
    "Czy interesują Cię mieszkania energooszczędne?",
    "Czy interesują Cię oferty ekonomiczne (niskie koszty)?",
    "Czy interesują Cię oferty luksusowe?",
    "Czy oferta ma być przyjazna zwierzętom?",
    "Czy interesuje Cię najem krótkoterminowy?",
    "Czy interesuje Cię najem długoterminowy?",
    "Czy oferta ma być dostępna od zaraz?"
]

_buy = [
    "Czy zależy Ci na atrakcyjnym mieszkaniu (dużym, blisko centrum, w dobrym stanie)?",
    "Czy interesuje Cię oferta sprzedaży odpowiednia dla rodziny?",
    "Czy interesują Cię oferty inwestycyjne (atrakcyjna cena za m2, dobra lokalizacja)?",
    "Czy chcesz filtrować mieszkania ze standardem wysokim?",
    "Czy interesują Cię mieszkania umeblowane?"
]

_buy_label = "Kupić"
_rent_label = "Wynająć"
_yes_label = "Tak"
_no_label = "Nie"

class ChatWindow(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Ekspert od nieruchomości")
        self.showMaximized()
        self.setStyleSheet("background-color: #232323; color: #fff;")
        self.setGeometry(0, 0, 750, 600)

        self.questions = [
            "Czy chcesz kupić, czy wynająć nieruchomość?"
        ]
        self.answers = []
        self.current_question = 0

        self.left_button_label = _buy_label
        self.right_button_label = _rent_label

        self.layout = QVBoxLayout(self)
        self.scroll = QScrollArea()
        self.scroll.setWidgetResizable(True)
        self.scroll.setVerticalScrollBarPolicy(Qt.ScrollBarAlwaysOn)
        self.scroll.setHorizontalScrollBarPolicy(Qt.ScrollBarAlwaysOff)
        self.scroll.setStyleSheet('''
            QScrollBar:vertical {
                background: #232323;
                width: 12px;
                margin: 0px 0px 0px 0px;
                border-radius: 6px;
            }
            QScrollBar::handle:vertical {
                background: #888;
                min-height: 30px;
                border-radius: 6px;
            }
            QScrollBar::add-line:vertical, QScrollBar::sub-line:vertical {
                height: 0px;
                subcontrol-origin: margin;
            }
            QScrollBar::add-page:vertical, QScrollBar::sub-page:vertical {
                background: none;
            }
        ''')
        self.chat_content = QVBoxLayout()
        self.chat_content.addStretch(1)
        self.chat_widget = QWidget()
        self.chat_widget.setLayout(self.chat_content)
        self.chat_widget.setStyleSheet("background-color: #232323;")
        self.scroll.setWidget(self.chat_widget)
        self.layout.addWidget(self.scroll)


        self.button_layout = QHBoxLayout()
        self.left_button = QPushButton(self.left_button_label)
        self.right_button = QPushButton(self.right_button_label)
        button_style = (
            "QPushButton {"
            "background-color: #2196F3;"
            "color: #fff;"
            "border-radius: 10px;"
            "padding: 8px 24px;"
            "font-size: 16px;"
            "}"
            "QPushButton:pressed {"
            "background-color: #1976D2;"
            "}"
            "QPushButton:disabled {"
            "background-color: #78909C;"
            "}"
        )
        self.left_button.setStyleSheet(button_style)
        self.right_button.setStyleSheet(button_style)
        self.left_button.clicked.connect(lambda: self.handle_answer(self.left_button_label))
        self.right_button.clicked.connect(lambda: self.handle_answer(self.right_button_label))
        self.button_layout.addWidget(self.left_button)
        self.button_layout.addWidget(self.right_button)
        self.layout.addLayout(self.button_layout)

        self.show_question()

    def show_question(self):
        if self.current_question < len(self.questions):
            self.add_message(self.questions[self.current_question])
        else:
            self.show_result()

    def add_message(self, text, is_user=False):
        msg = QLabel(text)
        msg.setWordWrap(True)

        if is_user:
            msg.setStyleSheet(
                "background-color: #2196F3; color: #fff; border-radius: 10px; padding: 8px; margin: 0px; font-size: 16px;"
            )
        else:
            msg.setStyleSheet(
                "background-color: #eee; color: #232323; border-radius: 10px; padding: 8px; margin: 0px; font-size: 16px;"
            )

        row_widget = QWidget()
        row_layout = QHBoxLayout()
        row_layout.setContentsMargins(0, 0, 0, 0)
        row_layout.setSpacing(0)
        if is_user:
            row_layout.addStretch()
            row_layout.addWidget(msg)
        else:
            row_layout.addWidget(msg)
            row_layout.addStretch()
        row_widget.setLayout(row_layout)

        self.chat_content.insertWidget(self.chat_content.count() - 1, row_widget)
        QApplication.processEvents()
        QTimer.singleShot(0, lambda: self.scroll.verticalScrollBar().setValue(self.scroll.verticalScrollBar().maximum()))

    def handle_answer(self, answer):
        self.add_message(answer, is_user=True)
        self.answers.append(answer)
        if answer == _buy_label:
            self.questions.extend(_buy)
        elif answer == _rent_label:
            self.questions.extend(_rent)
        self.current_question += 1
        self.show_question()
        if answer in [_buy_label, _rent_label]:
            self.left_button_label = _yes_label
            self.right_button_label = _no_label
            self.left_button.setText(self.left_button_label)
            self.right_button.setText(self.right_button_label)

    def show_result(self):
        self.left_button.setDisabled(True)
        self.right_button.setDisabled(True)
        prolog_answers = ['t' if a == 'Tak' else 'n' for a in self.answers[1:]]
        prolog = Prolog()

        prolog.consult(os.path.join("nieruchomosci", "start.pl"))
        csvPath = os.path.join("nieruchomosci", "baza_wiedzy", "csv")

        if self.answers[0] == _rent_label:
            filters = f"""filtry{{
                dla_studenta: {prolog_answers[0]},
                dla_rodziny: {prolog_answers[1]},
                dla_seniora: {prolog_answers[2]},
                nowe: {prolog_answers[3]},
                energooszczedne: {prolog_answers[4]},
                ekonomiczne: {prolog_answers[5]},
                luksusowe: {prolog_answers[6]},
                przyjazne_zwierzetom: {prolog_answers[7]},
                krotkoterminowe: {prolog_answers[8]},
                dlugoterminowe: {prolog_answers[9]},
                dostepne_od_zaraz: {prolog_answers[10]}
            }}"""
            query = (
                f"read_nieruchomosci_from_csv('{os.path.join(csvPath, 'nieruchomosci.csv')}', Nieruchomosci),"
                f"read_oferty_wynajmu_from_csv('{os.path.join(csvPath, 'oferty_wynajmu.csv')}', OfertyWynajmu),"
                f"filtruj_i_wypisz_wynajem({filters}, Nieruchomosci, OfertyWynajmu, PasujaceNieruchomosci)"
            )
        else:
            filters = f"""filtry{{
                atrakcyjne: {prolog_answers[0]},
                dla_rodziny: {prolog_answers[1]},
                inwestycyjne: {prolog_answers[2]},
                wysoki_standard: {prolog_answers[3]},
                umeblowane: {prolog_answers[4]}
            }}"""
            query = (
                f"read_nieruchomosci_from_csv('{os.path.join(csvPath, 'nieruchomosci.csv')}', Nieruchomosci),"
                f"read_oferty_sprzedazy_from_csv('{os.path.join(csvPath, 'oferty_sprzedazy.csv')}', OfertySprzedazy),"
                f"filtruj_i_wypisz_sprzedaz({filters}, Nieruchomosci, OfertySprzedazy, PasujaceNieruchomosci)"
            )

        offers = list(list(prolog.query(query))[0]['PasujaceNieruchomosci'])
        print(offers)
    
        if offers:
            formatted = [self.print_offer(o) for o in offers]
            recommendation = "Znaleziono pasujące oferty:\n" + "\n".join(formatted)
        else:
            recommendation = "Nie znaleziono pasujących ofert"
        self.add_message(recommendation)
    
    def print_offer(self, offer):
        try:
            offer = str(offer)
            offer = offer.removeprefix("nieruchomosc(")
            offer = offer.removesuffix(")")
            offer = offer.split(",")
            id_ = offer[0].strip()
            typ = offer[1].strip()
            lokalizacja = offer[2].strip()
            powierzchnia = offer[11].strip()
            return f"ID: {id_}, Typ: {typ}, Lokalizacja: {lokalizacja}, Powierzchnia: {powierzchnia} m2"
        except Exception:
            return offer

if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = ChatWindow()
    window.show()
    sys.exit(app.exec_())
