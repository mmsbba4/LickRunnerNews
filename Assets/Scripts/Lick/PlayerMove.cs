using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Obi;
namespace Lick
{
    public class PlayerMove : MonoBehaviour
    {

        public bool Replaying;
        public List<int> blend_index;
        AIpressed m_auto_press;
        public bool is_player;
        Rigidbody rb;
        public float speed;
        public SkinnedMeshRenderer r;
        public SkinnedMeshRenderer head;
        public float pressed_value, emoji_value;
        public float increse_press_value;
        public bool is_on_cake;
        public emoji current_emoji;
        public DestroyType current_destroyable_type;
        public bool is_can_control;
        public Animator m_amin;
        public bool is_start = false;
        public Transform character;
        public BlendIndex m_blend;
        public GameObject lick_effect;

        bool is_can_lick;
        public Collider m_tounge_collider;
        public bool IsCanLick
        {
            get
            {
                return is_can_lick;
            }
            set
            {
                is_can_lick = value;
                if (is_can_lick)
                {
                    real_tongule.SetActive(true);
                    
                }
                else
                {
                    real_tongule.SetActive(false);
                    lick_effect.SetActive(false);
                }
                
            }
        }
        public void SetHead(SkinnedMeshRenderer renderer)
        {
            m_blend = renderer.GetComponent<BlendIndex>();
            head = renderer;
        }

        private void Start()
        {
            rb = GetComponent<Rigidbody>();
            if (!is_player)
            {
                m_auto_press = GetComponent<AIpressed>();
                m_blend = head.GetComponent<BlendIndex>();
            }
        }

        public void PlayerDeath()
        {
            StartCoroutine(_PlayerDeath());
        }
        public GameObject real_tongule;

        
        [Header("Player Effect")]
        [Space(50)]
        public MeshRenderer rod_renderer;
        public Material rod_mat;
        public Obi.ObiParticleAttachment attach;

        IEnumerator _PlayerDeath()
        {
            IsCanLick = false;
            if (is_player)
            {
                Destroy(real_tongule.gameObject);
                //real_tongule.SetActive(false);
                rod_renderer.material = rod_mat;
                attach.enabled = false;
            }
            else
            {
                real_tongule.SetActive(false);
            }
            current_emoji = emoji.def;
            float delta = 0;
            while (delta < 1)
            {
                delta += Time.deltaTime;
                SetBlendShapeEmoji(Mathf.Lerp(0, 100, delta));
                yield return new WaitForEndOfFrame();
            }
            rb.constraints = RigidbodyConstraints.None;
            rb.velocity = new Vector3(0, 0.5f, -2) * 5;
            rb.AddTorque(transform.right * 50, ForceMode.Acceleration);
        }

        public void StopMove()
        {
            is_start = false;
            IsCanLick = false;
        }
        public void SetMove()
        {
            is_start = true;
            IsCanLick = true;
        }
        void Update()
        {
            if (!is_start) return;
            transform.Translate(transform.forward * speed * Time.deltaTime);
            if (!is_can_control) return;

            if (!Replaying)
            {
                if (is_player)
                {
                    if (Input.GetKey(KeyCode.Space))
                    {
                        pressed_value -= Time.deltaTime * increse_press_value;
                        pressed_value = Mathf.Clamp(pressed_value, 0, 100);
                    }
                    else
                    {
                        pressed_value += Time.deltaTime * increse_press_value;
                        pressed_value = Mathf.Clamp(pressed_value, 0, 100);
                    }
                }
                else
                {
                    if (m_auto_press.is_pressed)
                    {
                        pressed_value -= Time.deltaTime * increse_press_value;
                        pressed_value = Mathf.Clamp(pressed_value, 0, 100);
                    }
                    else
                    {
                        pressed_value += Time.deltaTime * increse_press_value;
                        pressed_value = Mathf.Clamp(pressed_value, 0, 100);
                    }
                }
            }
            SetBlendshapeWeigth(pressed_value);
            if (is_on_cake && IsCanLick)
            {// trong banh
                if (pressed_value < 5)
                {
                    if (!lick_effect.activeInHierarchy)
                    {
                        lick_effect.SetActive(true);
                    }
                    //dang liem
                    if (current_emoji == emoji.happy)
                    {
                        if (!is_fat)
                        Fat();
                        
                    }
                    else
                    {
                        if (is_fat)
                            UnFat();
                    }
                    emoji_value += Time.deltaTime * increse_press_value / 2;
                    emoji_value = Mathf.Clamp(emoji_value, 0, 100);
                    SetBlendShapeEmoji(emoji_value);
                }
                else
                {
                    if (lick_effect.activeInHierarchy)
                    {
                        lick_effect.SetActive(false);
                    }
                    emoji_value -= Time.deltaTime * increse_press_value / 2;
                    emoji_value = Mathf.Clamp(emoji_value, 0, 100);
                    SetBlendShapeEmoji(emoji_value);
                }
            }
            else
            {
                if (lick_effect.activeInHierarchy)
                {
                    lick_effect.SetActive(false);
                }
                emoji_value -= Time.deltaTime * increse_press_value / 2;
                emoji_value = Mathf.Clamp(emoji_value, 0, 100);
                SetBlendShapeEmoji(emoji_value);
            }

        }

        public void Faild()
        {
            rb.constraints = RigidbodyConstraints.None;
            Destroy(this);
        }
        public void SetBlendshapeWeigth(float value)
        {
            r.SetBlendShapeWeight(0, value);
        }
        public void SetBlendShapeEmoji(float value)
        {
            for (int i = 0; i< 4; i++)
            {
                if (i == (int)current_emoji)
                {
                    head.SetBlendShapeWeight(m_blend.GetBlendIndex((int)current_emoji), value);
                }
                else
                {
                   if(i!= 3)
                   head.SetBlendShapeWeight(m_blend.GetBlendIndex(i), 0);
                }
            }
            
        }
        public void SetEmoji( emoji emoji)
        {
            current_emoji = emoji;
        }
        public void SetDestroyable(DestroyType type)
        {
            UnFat();
            switch (type)
            {
                case DestroyType.Cut:
                    {
                        Cut();
                        break;
                    }
                case DestroyType.Fire:
                    {
                        Fire();
                        break;
                    }
                case DestroyType.Decorticate:
                    {
                        Decorticate();
                        break;
                    }
                case DestroyType.Freezee:
                    {
                        Freezee();
                        break;
                    }
            }
        }
        bool is_fat = false;
        public void Fat()
        {
            is_fat = true;
            StartCoroutine(m_Fat());
        }
        IEnumerator m_Fat()
        {
           float tmp = 0;
           speed = 6;
            while (tmp < 50)
           {
                tmp += Time.deltaTime * increse_press_value / 2;
                head.SetBlendShapeWeight(m_blend.GetBlendIndex(3), tmp);
                yield return new WaitForEndOfFrame();
           }
        }
        public void UnFat()
        {
            is_fat = false;
            speed = 4;
            head.SetBlendShapeWeight(m_blend.GetBlendIndex( 3), 0);
        }

        public void Cut()
        {
            current_emoji = emoji.def;
            StartCoroutine(m_Cut());
        }
        IEnumerator m_Cut()
        {
            is_can_control = false;
            IsCanLick = false;
            GameObject eff = Instantiate(Resources.Load("break_effect") as GameObject,character);
            eff.transform.localPosition = r.transform.localPosition;
            float tmp = 0;
            while (tmp < 100)
            {
                tmp += Time.deltaTime * increse_press_value / 2;
                SetBlendShapeEmoji(tmp);
                yield return new WaitForEndOfFrame();
            }
            yield return new WaitForSeconds(1);
            eff.GetComponent<Break_effect>().OnDestro();
            IsCanLick = true;
            is_can_control = true;
        }
        void Fire()
        {
            current_emoji = emoji.def;
            StartCoroutine(m_Fire());
        }
        IEnumerator m_Fire()
        {
            speed = speed / 2f;
            is_can_control = false;
            float tmp = 0;
            while (tmp < 100)
            {
                tmp += Time.deltaTime* increse_press_value / 2;
                SetBlendShapeEmoji(tmp);
                yield return new WaitForEndOfFrame();
            }
            yield return new WaitForSeconds(1);
            speed = speed * 2f;
            pressed_value = 10;
            while (tmp > 10)
            {
                tmp -= Time.deltaTime * increse_press_value / 2;
                SetBlendShapeEmoji(tmp);
                yield return new WaitForEndOfFrame();
            }
            is_can_control = true;
        }

        void Freezee()
        {
            current_emoji = emoji.def;
            StartCoroutine(m_Freezee());
        }
        IEnumerator m_Freezee()
        {
            speed = 0;
            is_can_control = false;
            pressed_value = 20;
            m_amin.SetBool("frozzen", true);
            float tmp = 0;
            while (tmp < 100)
            {
                tmp += Time.deltaTime * increse_press_value / 2;
                SetBlendShapeEmoji(tmp);
                yield return new WaitForEndOfFrame();
            }
            yield return new WaitForSeconds(2);
            speed = 4;
            m_amin.SetBool("frozzen", false);
            is_can_control = true;
            Cut();

        }
        void Decorticate()
        {
            StartCoroutine(m_Decorticate());
        }
        public Vector3 Decorticate_position;
        IEnumerator m_Decorticate()
        {
            speed = 0;
            is_can_control = false;
            Vector3 pos = transform.position;
            transform.position = Decorticate_position;
            m_amin.SetBool("decorate", true);
            SetBlendshapeWeigth(10);
            float tmp = 0;
            current_emoji = emoji.disgust;
            while (tmp < 100)
            {
                tmp += Time.deltaTime * increse_press_value / 2;
                SetBlendShapeEmoji(tmp);
                yield return new WaitForEndOfFrame();
            }
            yield return new WaitForSeconds(1);
            m_amin.SetBool("decorate", false);
            speed = 4;
            transform.position = new Vector3(transform.position.x, pos.y, transform.position.z); 
            Cut();
        }

    }

}

