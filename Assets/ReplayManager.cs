using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.IO;
using System.Reflection;
using UnityEngine.Events;
using UnityEngine.SceneManagement;
using System;
namespace Lick
{
    public class ReplayManager : MonoBehaviour
    {
        public static ReplayManager instance;
        private MemoryStream memoryStream = null;
        private BinaryWriter binaryWriter = null;
        private BinaryReader binaryReader = null;
        private bool recordingInitialized;
        bool is_writing = false;
        public UnityEvent OnCompleteRePlay;
        public  PlayerMove player_1, player_2, player_3;
        public WinProcess m_win_process;
        public string path;
        public bool ReadScene = true;
        private void Awake()
        {
            instance = this;
            print(PlayerPrefs.GetInt("replay")+"????????????????");
            if (PlayerPrefs.GetInt("replay") == 1)
            {
                print("is replay Scene...");
                path = PlayerPrefs.GetString("replay_path");
                ReadScene = true;
                player_1.Replaying = true;
                player_2.Replaying = true;
                player_3.Replaying = true;
                m_win_process.Replaying = true;
            }
            else
            {

                ReadScene = false;
                player_1.Replaying = false;
                player_2.Replaying = false;
                player_3.Replaying = false;
                m_win_process.Replaying = false;
            }
        }
        private void Start()
        {
            if (!recordingInitialized)
            {
                InitializeRecording();
            }
            else
            {
                memoryStream.SetLength(0);
            }
            if (ReadScene)
            {
                ReadFileStream();
            }
        }
        public void StartRePlay()
        {
            if (!ReadScene) return;
            print("Start Replay at " + Time.timeSinceLevelLoad);
            memoryStream.Position = 0;
            is_reading = true;
        }
        public void StartRecoding()
        {
            if (ReadScene) return;
            print("Start Write at " + Time.timeSinceLevelLoad);
            is_writing = true;
        }

        public void StopRecording()
        {
            if (ReadScene) return;
            print("Stop recoding at " + Time.timeSinceLevelLoad);
            is_writing = false;
            CopyStream(memoryStream);
        }

        private void ResetReplayFrame()
        {
            memoryStream.Seek(0, SeekOrigin.Begin);
            binaryWriter.Seek(0, SeekOrigin.Begin);
        }


        private void InitializeRecording()
        {
            memoryStream = new MemoryStream();
            binaryWriter = new BinaryWriter(memoryStream);
            binaryReader = new BinaryReader(memoryStream);
            recordingInitialized = true;
        }
        private void SaveTransforms(Transform transform)
        {
            binaryWriter.Write(player_1.pressed_value);
            binaryWriter.Write(player_2.pressed_value);
            binaryWriter.Write(player_3.pressed_value);
            binaryWriter.Write(m_win_process.force);
            binaryWriter.Write(m_win_process.target_1.localPosition.x);
            binaryWriter.Write(m_win_process.target_1.localPosition.y);
            binaryWriter.Write(m_win_process.target_1.localPosition.z);
        }

        private void LoadTransforms(Transform transform)
        {
            player_1.pressed_value = binaryReader.ReadSingle();
            player_2.pressed_value = binaryReader.ReadSingle();
            player_3.pressed_value = binaryReader.ReadSingle();
            m_win_process.force = binaryReader.ReadSingle();
            float x = binaryReader.ReadSingle();
            float y = binaryReader.ReadSingle();
            float z = binaryReader.ReadSingle();
            Vector3 pos = new Vector3(x,y,z);
            m_win_process.target_1.localPosition = pos;
        }
        bool is_reading = false;
        void FixedUpdate()
        {
            if (is_writing)
            {
                print("Recording........");
                SaveTransforms(transform);
            }
            if (is_reading)
            {
                if (memoryStream.Position >= memoryStream.Length)
                {

                    OnCompleteRePlay.Invoke();
                    is_reading = false;
                    print("Replay complete at  : " + Time.timeSinceLevelLoad);
                    return;
                }
                else
                {
                    LoadTransforms(transform);

                }
            }

        }
        // save Stream
        public void CopyStream(MemoryStream stream)
        {
            string path = Application.streamingAssetsPath + "/" + SceneManager.GetActiveScene().name + "-" + DateTime.Now.ToLongDateString() + " " + DateTime.Now.Hour + " " + DateTime.Now.Minute + " " + DateTime.Now.Second;
            using (var fileStream = new FileStream(path, FileMode.Create, FileAccess.Write))
            {
                stream.WriteTo(fileStream);
            }
            print("Saved" + memoryStream.Length + " to " + path);
        }
        // read Stream
        void ReadFileStream()
        {
            //using (MemoryStream ms = new MemoryStream())
            //    path = PlayerPrefs.GetString("replay_path");

            using (FileStream file = new FileStream(path, FileMode.Open, FileAccess.Read))
            {
                byte[] bytes = new byte[file.Length];
                file.Read(bytes, 0, (int)file.Length);
                memoryStream.SetLength(0);
                memoryStream.Write(bytes, 0, (int)file.Length);
                print(bytes.Length);
            }
            print("Read length :" + memoryStream.Length + "at " + PlayerPrefs.GetString("replay_path"));
        }
    }

}
