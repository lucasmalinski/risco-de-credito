for name in ['notebooks/01_eda.ipynb', 'notebooks/02_ml_models.ipynb']:
    try:
        with open(name, 'r', encoding='utf-8') as f:
            content = f.read()
        # Corrige a quebra de linha inválida do JSON
        fixed_content = content.replace('\\\\n\\n', '\\\\n').replace('\\\\n\\n', '\\\\n')
        # Testa se o JSON ficou válido
        import json
        json.loads(fixed_content)
        with open(name, 'w', encoding='utf-8') as f:
            f.write(fixed_content)
        print(f'✅ {name} corrigido com sucesso!')
    except Exception as e:
        print(f'❌ Erro ao corrigir {name}: {e}')