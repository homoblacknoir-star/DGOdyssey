# AI Agent Instructions for DGOdyssey

This document provides essential context for AI coding assistants working with the DGOdyssey codebase, a Godot-based game using Dialogic 2 for visual novel/RPG mechanics.

## Project Architecture

### Core Components
- Scene Management: Organized in `/Scene` with episode-based scenes (EP01.tscn, EP02.tscn)
- Dialog System: Uses Dialogic 2 framework (`/addons/dialogic/`) with custom hooks
- Character Management: Split between `/Character` (assets) and dialog character definitions
- Global State: Managed through `global.gd` singleton
- Autoloads: Key systems in `/autoloads/` including player and dialog management

### Key Integration Points
1. **Dialog System Integration**
   - Custom hooks in `autoloads/DialogHooks.gd` for player interactions
   - Dialog files in `/Dialog` using .dtl format
   - Timeline flows defined in files like `EP01_v10.8_TH_classroom_flow.dtl`

2. **Scene Flow**
   - Main scenes in `/Scene` directory control episode progression
   - Transitions managed through `scene_transition.gd`
   - Background scenes (`background_scene_*.tscn`) for environment management

3. **Interaction System**
   - Core manager in `Object/interaction_manager.gd`
   - Area2D-based interaction zones (`Object/InteractArea/`)
   - Character-specific interactions (e.g., `Object/alex_pc.gd`)

## Development Workflows

### Scene Creation Pattern
1. Create main scene file in `/Scene`
2. Set up background using background_scene template
3. Add interaction areas using InteractionManager
4. Link dialog timelines from `/Dialog`

### Dialog Development
1. Place .dtl files in `/Dialog` directory
2. Reference characters from Character/ directory
3. Connect through DialogHooks for player interactions
4. Test flows using timeline.dtl for verification

## Project Conventions

### File Organization
- Episode-specific content prefixed with EP0X (e.g., EP01_, EP02_)
- Scene objects in `/Object/EP0XObject/`
- Dialog files use descriptive suffixes (_flow, _full, _dtl)

### Coding Patterns
- State management through global singleton
- Scene-based architecture with dedicated scripts
- Character states tracked via global variables
- Interaction zones using Area2D nodes

## Common Tasks

### Adding New Episodes
1. Create episode scene in `/Scene`
2. Set up required dialog files in `/Dialog`
3. Add episode-specific objects in `/Object/EP0XObject`
4. Update scene transitions in `scene_transition.gd`

### Character Integration
1. Add character assets to `/Character/{CharacterName}/`
2. Create dialog character definitions
3. Update global state variables if needed
4. Add interaction areas if character is interactive

## Key Files for Reference
- `global.gd`: Central state management
- `Scene/EP01.tscn`: Example episode structure
- `Object/interaction_manager.gd`: Core interaction system
- `autoloads/DialogHooks.gd`: Dialog system integration

_Note: This codebase uses Godot 4.3+ and Dialogic 2. Ensure you have compatible versions when working with the project._