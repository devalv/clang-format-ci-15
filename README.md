# clang-format-ci-15
Обёртка для запуска clang-format-15 и run-clang-format.py в CI

## Что это такое и как с этим работать?
За основу взят [clang-format-checker-docker](https://github.com/Witekio/clang-format-checker-docker), который, в свою очередь, опирается на [run-clang-format](https://github.com/Sarcasm/run-clang-format).

clang-format-checker-docker взят как практическая идея реализации и адаптирован под 15ю версию clang-format (Смотри [Dockerfile](./.clang-format.example), run-clang-format нужен для удобного рекурсивного обхода и простоты запуска в процессе CI/CD. Сама версия run-clang-format.py зафиксирована на 06.12.2024 и не будет обновляться без острой необходимости (поэтому нет сабмодуля).

Без дополнительных параметров будет использован `.clang-format` находящийся в вашем репозитории.

### Что нужно, чтобы это применить?
Ничего. Просто подключите собранный мною docker-образ, либо соберите свой по аналогии.
Если "наработки" покажутся полезными - поставьте мне звёздочку, мне будет приятно и я буду знать, что это пригодилось кому-то ещё.

### Пример добавления задания в .gitlab-ci.yml

```yaml
stages:
  - lint

clang-checker:
  stage: lint
  image:
    # https://github.com/devalv/clang-format-ci-15 
    name: devalv/clang-format-15:0.0.1
    entrypoint: [""]
  script:
    - run-clang-format.py -r src
  tags:
    - docker
  only:
    refs:
      - merge_requests
    changes:
      - src/**/*
      - .clang-format
```

### Пример содержимого .clang-format
Смотри [.clang-format.example](./.clang-format.example)

## Аргументы, которые можно передать при запуске:
    '--clang-format-executable'
        help = path to the clang-format executable
        default = 'clang-format'
    
    '--extensions'
        help = comma separated list of file extensions
        default = 'c,h,C,H,cpp,hpp,cc,hh,c++,h++,cxx,hxx'
    
    '-r', '--recursive'
        help = run recursively over directories

    '-d', '--dry-run',
        help = just print the list of files

    '-i', '--in-place'
    help = format file instead of printing differences

    '-q', '--quiet',
        help = disable output, useful for the exit code
   
    '-j'
        help = run N clang-format jobs in parallel
        default = 0
        
    '--color'
        help = show colored diff
        default = auto
        choices=['auto', 'always', 'never']

    '-e', '--exclude'
        help = exclude paths matching the given glob-like pattern(s) from recursive search
    
    '--style'
        help = formatting style to apply (LLVM, Google, Chromium, Mozilla, WebKit)


## Как собрать новую версию?
1. Актуализируйте Dockerfile
2. Выполните docker-build
3. Выпоните docker-push

## Какие хуки настроены при выпуске релиза?
Добавлен github-action на автопубликацию в мой docker-hub, т.е., после mr-а в main необходимо создать релиз, прикрепить tag и он будет использован для публикации. 
  !latest - не используется!

## Как вносить изменения
Создайте МР с изменениями и назначьте меня ревьюером.
