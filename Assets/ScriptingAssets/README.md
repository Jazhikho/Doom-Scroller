# Godot 4 Reusable Systems

This folder contains reusable Godot 4.x GDScript systems. Copy individual `.gd` files into a project's `scripts/systems` folder when needed.

These systems are intended to follow the Signal Rift pattern:

- Systems handle focused reusable behavior.
- Project scripts own orchestration and game-specific consequences.
- Scenes/resources own editable layout and tuning where practical.
- Imported systems are documented in the target project's source or asset ledger.

## Current Source Policy

Most files originated in `D:\GeneralWorkingFolder\Godot AI Setup\Systems`, but that one-time setup workflow is legacy. The code systems have been promoted; the setup scripts have not.

Some systems were promoted from Signal Rift because they were created or improved during a stronger AI-generation workflow:

- `AudioJukeboxSystem.gd`
- `ShieldRegenSystem.gd`
- `TargetLockSystem.gd`
- `PointDefenseSystem.gd`
- `UIFontSystem.gd`

No Place by the Fire contributed the first-person controller family:

- `FirstPersonInputBootstrap.gd`
- `FirstPersonLookSettings.gd`
- `FirstPersonMotorMath.gd`
- `FirstPersonMovementController.gd`

These are GDScript helper systems. In No Place by the Fire itself, repo rules prefer C# for durable reusable gameplay/data systems, so future work may port these to C# if they become foundational.

See `..\SOURCE_LEDGER.md` before release use.

## 2026-07-21 Baseline Expansion

The newer baseline systems are generated reusable foundations and domain packs. They parse in Godot 4.7, but they have not been validated in a real target project. Each script carries an `UNTESTED` note and should be reviewed, integrated, and tested before production use.

## Validation

There is no standalone Godot project in this folder. Validate each system in the target project that imports it. For Signal Rift-style projects, the preferred quick gate is a headless Godot scene run after integration.
